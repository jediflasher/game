//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game {

	import com.greensock.TweenLite;
	import com.greensock.TweenNano;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;

	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import ru.catAndBall.data.game.field.GridCellData;

	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.field.PestGridCellData;
	import ru.catAndBall.view.core.display.BaseSprite;
	import ru.catAndBall.view.core.game.GridCell;
	import ru.catAndBall.view.screens.BaseScreen;

	import starling.display.Image;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                24.06.14 12:02
	 */
	public class GridField extends BaseSprite {

		//--------------------------------------------------------------------------
		//
		//  Events
		//
		//--------------------------------------------------------------------------

		public static const EVENT_COLLECT_CELLS:String = 'collectCells';

		public static const EVENT_HIGHLIGHT_START:String = 'highlightStart';

		public static const EVENT_HIGHLIGHT_COMPLETE:String = 'highlightComplete';

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const CELL_MARGIN:int = 23;

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GridField(data:GridData) {
			super();

			_data = data;
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

		private const _helperRect:Rectangle = new Rectangle();

		private const _helperPoint:Point = new Point();

		private const _selectedQueue:Vector.<GridCell> = new Vector.<GridCell>();

		private const _baseContainer:Sprite = new Sprite();

		private const _lineLayer:LineLayer = new LineLayer();

		private var _hashDataToView:Dictionary = new Dictionary();

		private var _mouseDown:Boolean = false;

		private var _clickDisabled:Boolean = false;

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
				cell.$data = data;
				_hashDataToView[data] = cell;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function added(event:* = null):void {
			addChild(_baseContainer);
			addChild(_lineLayer);

			_data.addEventListener(GridData.EVENT_UPDATE_FIELD, updateCellPositions);
			buildField();

			addEventListener(TouchEvent.TOUCH, handler_cellTouch);
		}

		protected override function removed(event:* = null):void {
			_lineLayer.clear();
			_baseContainer.removeChildren(0, -1, true);
			_selectedQueue.length = 0;
			_mouseDown = false;
			_hashDataToView = new Dictionary();
			if (_data) _data.removeEventListener(GridData.EVENT_UPDATE_FIELD, updateCellPositions);

			removeEventListener(TouchEvent.TOUCH, handler_cellTouch);

			super.removed(event);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function buildField():void {
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

						_baseContainer.addChild(view);
						_hashDataToView[data] = view;
					}
				}
			}
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
						_baseContainer.addChild(view);
						_hashDataToView[data] = view;
						viewNew = true;
					}

					var coords:Point = getCoordsByCell(view, i, j);
					view.x = coords.x;
					if (viewNew) {
						view.y = coords.y;
						view.width = 2;
						view.height = 2;
						TweenLite.to(view, 0.2, {width: GridCell.SIZE, height: GridCell.SIZE, delay: 0.2});
					} else {
						TweenLite.to(view, 0.5, {y: coords.y, ease: Back.easeOut});
					}
				}
			}
		}

		private function getCoordsByCell(cell:GridCell, col:int, row:int):Point {
			_helperPoint.x = int(col * (cell.size + CELL_MARGIN));
			_helperPoint.y = int(row * (cell.size + CELL_MARGIN));
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

		private function highlightCellsByType(cellType:int):void {
			for (var i:int = 0; i < _data.columns; i++) {
				for (var j:int = 0; j < _data.rows; j++) {
					var cellData:GridCellData = _data.cellsMatrix[i][j];
					var view:GridCell = _hashDataToView[cellData];
					view.darken();
				}
			}
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

			dispatchEventWith(EVENT_HIGHLIGHT_START);
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
				if (len > 2) {
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
				if (success && cell.selected) {
					delete _hashDataToView[cell.data];
					cell.selected = false;
				}
			}

			if (!success) {
				_baseContainer.filter = null;
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

			_baseContainer.filter = null;
			_clickDisabled = false;

			dispatchEventWith(EVENT_HIGHLIGHT_COMPLETE);
		}

		private function flyPest(toCell:GridCell, pestData:PestGridCellData):void {
			touchable = false;

			var point:Point = getCoordsByCell(toCell, pestData.prevColumn, pestData.prevRow);
			var img:Image = new Image(GridCellTextureFactory.getTextureByType(pestData.type));
			img.width = img.height = toCell.size;
			img.alignPivot();
			img.x = point.x;
			img.y = point.y;
			addChild(img);

			point = getCoordsByCell(toCell, pestData.column, pestData.row);

			var jumpTime:Number = 0.8;
			TweenNano.to(img, jumpTime, {x:point.x, onComplete:flyPestComplete, onCompleteParams:[img, toCell, pestData]});

			var firstPartY:Number = Math.min(img.y, point.y) - toCell.size;
			var yTime:Number = jumpTime/2;
			TweenNano.to(img, yTime, {y:firstPartY, scaleX:1.2, scaleY:1.2, overwrite:false, onComplete: secondPartFlyPest, onCompleteParams:[img, point.y, yTime]})
		}

		private function secondPartFlyPest(image:Image, targetY:Number, time:Number):void {
			TweenNano.to(image, time, {y:targetY, scaleY:1, scaleX:1, overwrite:false});
		}

		private function flyPestComplete(image:Image, toCell:GridCell, pestData:PestGridCellData):void {
			image.parent.removeChild(image);
			image.dispose();

			toCell.$data = pestData;
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
