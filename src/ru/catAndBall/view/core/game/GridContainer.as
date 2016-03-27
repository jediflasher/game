//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game {
	
	import com.greensock.TweenLite;
	import com.greensock.TweenNano;
	import com.greensock.easing.Bounce;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.field.PestGridCellData;
	import ru.catAndBall.view.core.game.field.GridBackground;
	import ru.catAndBall.view.layout.Layout;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                24.06.14 12:02
	 */
	public class GridContainer extends DisplayObjectContainer {

		//--------------------------------------------------------------------------
		//
		//  Events
		//
		//--------------------------------------------------------------------------

		public static const EVENT_COLLECT_CELLS:String = 'collectCells';

		public static const DARKEN_TEXTURE:Texture = Texture.fromBitmapData(new BitmapData(1, 1, true, 0xCC000000));

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GridContainer(data:GridData, background:GridBackground) {
			super();

			_data = data;
			_data.addEventListener(GridData.EVENT_FILL_FIELD, init);

			_background = background;
			init();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _data:GridData;

		public function get data():GridData {
			return _data;
		}


		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _background:GridBackground;

		private const _helperRect:Rectangle = new Rectangle();

		private const _helperPoint:Point = new Point();

		private const _selectedQueue:Vector.<GridCell> = new Vector.<GridCell>();

		private const _lineLayer:LineLayer = new LineLayer();

		private var _hashDataToView:Dictionary = new Dictionary();

		private var _mouseDown:Boolean = false;

		private var _clickDisabled:Boolean = false;

		private var _darkenImage:Image;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function removeCells(cells:Vector.<GridCellData>):void {
			for each(var cell:GridCellData in cells) {
				removeCell(cell);
			}
		}

		public function removeCell(cell:GridCellData):void {
			var cellView:GridCell = _hashDataToView[cell];
			if (cellView.parent) cellView.parent.removeChild(cellView);
			delete _hashDataToView[cellView.data];
			GridCell.toPool(cellView);
		}

		public function getCellByData(data:GridCellData):GridCell {
			return _hashDataToView[data];
		}

		public function setNewData(cell:GridCell, data:GridCellData):void {
			if (cell.data) delete _hashDataToView[cell.data];

			var pest:PestGridCellData = data as PestGridCellData;
			if (pest) {
				flyPest(cell, pest);
			} else {
				cell.updateData(data);
				_hashDataToView[data] = cell;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		public function clear():void {
			_lineLayer.clear();
			_selectedQueue.length = 0;
			_mouseDown = false;

			for (var d:* in _hashDataToView) {
				removeCell(d as GridCellData);
			}

			if (_data) _data.removeEventListener(GridData.EVENT_UPDATE_FIELD, updateCellPositions);


			removeEventListener(TouchEvent.TOUCH, handler_cellTouch);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function init(event:* = null):void {
			if (!_darkenImage) {
				_darkenImage = new Image(DARKEN_TEXTURE);
			}

			if (!_background.parent) {
				addChild(_background);
			}

			_data.addEventListener(GridData.EVENT_UPDATE_FIELD, updateCellPositions);
			buildField();
		}

		private function buildField(event:* = null):void {
			var columns:int = _data.columns;
			var rows:int = _data.rows;

			for (var i:int = 0; i < columns; i++) {
				var column:Vector.<GridCellData> = _data.getColumn(i);
				for (var j:int = 0; j < rows; j++) {
					var data:GridCellData = column[j];
					if (data) {
						var view:GridCell = GridCell.fromPool(data);
						var coords:Point = getCoordsByCell(view, i, j);
						view.x = coords.x;
						view.y = coords.y;

						addChild(view);
						_hashDataToView[data] = view;
					}
				}
			}

			addEventListener(TouchEvent.TOUCH, handler_cellTouch);
		}

		private function darken():void {
			var bounds:Rectangle = getBounds(this, _helperRect);
			_darkenImage.width = bounds.width;
			_darkenImage.height = bounds.height;
			_darkenImage.x = bounds.x;
			_darkenImage.y = bounds.y;
			addChild(_darkenImage);
		}

		private function undarken():void {
			removeChild(_darkenImage);
		}

		private function updateCellPositions(event:* = null):void {
			var columns:int = _data.columns;
			var rows:int = _data.rows;
			for (var i:int = 0; i < columns; i++) {
				var column:Vector.<GridCellData> = _data.getColumn(i);
				for (var j:int = 0; j < rows; j++) {
					var data:GridCellData = column[j];
					var viewNew:Boolean = false;

					var view:GridCell = _hashDataToView[data];
					if (!view) {
						view = GridCell.fromPool(data);
						addChild(view);
						_hashDataToView[data] = view;
						viewNew = true;
					}

					var coords:Point = getCoordsByCell(view, i, j);
					view.x = coords.x;
					if (viewNew) {
						view.y = coords.y;
						view.width = 2;
						view.height = 2;
						TweenLite.to(view, 0.2, {width: Layout.field.elementSize, height: Layout.field.elementSize, delay: 0.2});
					} else {
						TweenLite.to(view, 0.5, {y: coords.y, ease: Bounce.easeOut});
					}
				}
			}
		}

		private function getCoordsByCell(cell:GridCell, col:int, row:int):Point {
			_helperPoint.x = int(col * _background.elementSize) + _background.startX + _background.elementSize / 2;
			_helperPoint.y = int(row * _background.elementSize) + _background.startY + _background.elementSize / 2;
			return _helperPoint;
		}

		private function getCellUnderMouse(centerCell:GridCellData, mouseX:int, mouseY:int):GridCell {
			var fromX:int = centerCell.column - 1;
			var fromY:int = centerCell.row - 1;
			var toX:int = centerCell.column + 1;
			var toY:int = centerCell.row + 1;

			for (var i:int = fromX; i <= toX; i++) {
				for (var j:int = fromY; j <= toY; j++) {
					var cell:GridCellData = _data.getCellAt(i, j);
					if (!cell || cell == centerCell) continue;

					var view:GridCell = _hashDataToView[cell];

					view.getBounds(this, _helperRect);
					if (_helperRect.contains(mouseX, mouseY)) return view;
				}
			}

			return null;
		}

		private function highlightCellsByType(cellType:String):void {
			darken();
//			_screen.addRawChild(_screen.fieldContainer);

			var cells:Vector.<GridCellData> = _data.getCellsByType(cellType);
			var len:int = cells.length;

			for (var i:int = 0; i < len; i++) {
				var cellData:GridCellData = cells[i];
				var view:GridCell = _hashDataToView[cellData];
				addChild(view);
			}

			addChild(_lineLayer);
		}

		[Inline]
		private function touchStart(touch:Touch):void {
			if (_mouseDown || _clickDisabled) return;

			var cell:GridCell = touch.target.parent as GridCell;
			cell.selected = true;
			_selectedQueue.push(cell);

			highlightCellsByType(cell.data.type);
			_mouseDown = true;
			this._clickDisabled = true;
		}

		[Inline]
		private function touchMove(touch:Touch):void {
			var cell:GridCell = touch.target.parent as GridCell;
			var cellData:GridCellData = cell.data;
			var len:int = _selectedQueue.length;
			var lastCell:GridCell = len > 0 ? _selectedQueue[len - 1] : null;

			if (lastCell) {
				touch.getLocation(this, _helperPoint);
				cell = getCellUnderMouse(lastCell.data, _helperPoint.x, _helperPoint.y);
				if (!cell) return;
				cellData = cell.data;
			}

			if (lastCell && cellData.type != lastCell.data.type) return;

			if (!cell.selected) {
				if (!lastCell || cellData.isNeighbor(lastCell.data)) {
					cell.selected = true;
					_selectedQueue.push(cell);

					if (lastCell) _lineLayer.lineTo(lastCell.x, lastCell.y, cell.x, cell.y);
				}
			} else {
				if (len > 1) {
					var toRemove:int = 0;
					if (cell === _selectedQueue[len - 2] || cell === _selectedQueue[len - 1]) {
						toRemove = 1;
					} else if (cell === _selectedQueue[len - 3]) {
						toRemove = 2;
					}

					for (var i:int = 0; i < toRemove; i++) {
						var cellToRemove:GridCell = _selectedQueue.pop() as GridCell;
						cellToRemove.selected = false;
						_lineLayer.removeLastLine();
					}
				}
			}
		}

		[Inline]
		private function touchComplete():void {
			if (!_mouseDown) return;

			var len:int = _selectedQueue.length;
			var success:Boolean = len > 0 ? len >= _data.getCollectCount(_selectedQueue[0].data.type) : false;

			for (var i:int = 0; i < len; i++) {
				var cell:GridCell = _selectedQueue[i];
				if (success) delete _hashDataToView[cell.data];
				cell.selected = false;
			}

			if (!success) {
				_clickDisabled = false;
			} else {
				var result:Vector.<GridCellData> = new Vector.<GridCellData>();
				for each(cell in _selectedQueue) {
					result.push(cell.data);
					GridCell.toPool(cell);
				}
				dispatchEventWith(EVENT_COLLECT_CELLS, true, result);
			}

			_lineLayer.clear();
			_selectedQueue.length = 0;
			_mouseDown = false;

			_clickDisabled = false;

			undarken();
		}

		private function flyPest(toCell:GridCell, pestData:PestGridCellData):void {
			touchable = false;

			var point:Point = getCoordsByCell(toCell, pestData.prevColumn, pestData.prevRow);
			var img:Image = new Image(GridCellTextureFactory.getTextureByType(pestData.type));
			img.width = img.height = Layout.field.elementSize;
			img.alignPivot();
			img.x = point.x;
			img.y = point.y;
			addChild(img);

			point = getCoordsByCell(toCell, pestData.column, pestData.row);

			var jumpTime:Number = 0.8;
			TweenNano.to(img, jumpTime, {x: point.x, onComplete: flyPestComplete, onCompleteParams: [img, toCell, pestData]});

			var firstPartY:Number = Math.min(img.y, point.y) - Layout.field.elementSize;
			var yTime:Number = jumpTime / 2;
			TweenNano.to(img, yTime, {y: firstPartY, scaleX: 1.4, scaleY: 1.4, overwrite: false, onComplete: secondPartFlyPest, onCompleteParams: [img, point.y, yTime]})
		}

		private function secondPartFlyPest(image:Image, targetY:Number, time:Number):void {
			TweenNano.to(image, time, {y: targetY, scaleY: 1, scaleX: 1, overwrite: false});
		}

		private function flyPestComplete(image:Image, toCell:GridCell, pestData:PestGridCellData):void {
			removeChild(image);
			image.dispose();

			toCell.updateData(pestData, false);
			_hashDataToView[pestData] = toCell;

			touchable = true;
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_cellTouch(event:TouchEvent):void {
			var target:Image = event.target as Image;
			if (!target) return;

			if (!(target.parent is GridCell)) return;

			var touch:Touch;
			if (!_mouseDown) touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch) touchStart(touch);

			if (!_mouseDown) return;

			touch = event.getTouch(this, TouchPhase.ENDED);
			if (touch) touchComplete();

			touch = event.getTouch(this, TouchPhase.MOVED);
			if (touch) touchMove(touch);
		}
	}
}
