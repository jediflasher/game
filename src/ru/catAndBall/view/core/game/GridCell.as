//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game {

	import com.greensock.TweenNano;

	import flash.errors.IllegalOperationError;

	import ru.catAndBall.data.game.field.BombGridCellData;
	import ru.catAndBall.data.game.field.GridCellData;
	import ru.catAndBall.data.game.field.PestGridCellData;
	import ru.catAndBall.utils.Geometry;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.TextFieldBackground;
	import ru.catAndBall.view.layout.Layout;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                22.06.14 17:53
	 */
	public class GridCell extends Sprite implements IAnimatable {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const POOL:Vector.<GridCell> = new Vector.<GridCell>();

		private static var P:ConstructorPrivater;

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function fromPool(data:GridCellData):GridCell {
			if (POOL.length == 0) {
				if (!P) P = new ConstructorPrivater();

				var cell:GridCell = new GridCell(data, P);
				POOL.push(cell);
			}

			cell = POOL.pop() as GridCell;
			cell.$data = data;
			return cell;
		}

		public static function toPool(cell:GridCell):void {
			POOL.push(cell);
			if (cell.parent) cell.parent.removeChild(cell);
			cell.selected = false;
			cell.x = 0;
			cell.y = 0;
			cell.width = Layout.field.elementSize;
			cell.height = Layout.field.elementSize;
			cell.alpha = 1;
			cell.rotation = 0;
			cell.updateExplode();
			cell.$data = null;
			cell.updateCount();
			TweenNano.killTweensOf(cell);
		}

		public static function disposePool():void {
			for each (var cell:GridCell in POOL) cell.dispose();
			POOL.length = 0;
		}

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GridCell(data:GridCellData, privater:ConstructorPrivater) {
			super();
			_image = new Image(GridCellTextureFactory.getTextureByType(data.type));
			addChild(_image);

			if (!privater) throw new IllegalOperationError('Use method GridCell.fromPool');

			alignPivot(HAlign.CENTER, VAlign.CENTER);
			width = height = Layout.field.elementSize;
			_data = data;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _countTextField:TextFieldBackground;

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		private var _data:GridCellData;

		public function get data():GridCellData {
			return _data;
		}

		public function set $data(value:GridCellData):void {
			if (_data === value) return;

			if (_data) _data.removeEventListener(PestGridCellData.EVENT_TURNS_CHANGE, updateCount);
			var textureChanged:Boolean = _data && value ? _data.type != value.type : true;
			_data = value;

			if (_data) _data.addEventListener(PestGridCellData.EVENT_TURNS_CHANGE, updateCount);

			if (textureChanged) {
				if (stage) {
					playChangeTexture();
				} else {
					changeTexture();
				}
			}

			updateExplode();
			updateCount();
		}

		private var _selected:Boolean = false;

		public function get selected():Boolean {
			return _selected;
		}

		public function set selected(value:Boolean):void {
			if (_selected == value) return;

			_selected = value;
			var val:Number = _selected ? Layout.field.elementSize * 0.8 : Layout.field.elementSize;

			if (stage) {
				TweenNano.to(this, 0.1, {width: val, height: val});
			} else {
				width = height = val;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _addedToJuggler:Boolean = false;

		private var _image:Image;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function advanceTime(time:Number):void {
			rotation += Geometry.toRadians(5);
		}

		public function updateExplode():void {
			if ((_data is BombGridCellData) && (_data as BombGridCellData).readyToBlow) {
				if (!_addedToJuggler) {
					Starling.juggler.add(this);
					_addedToJuggler = true;
				}
			} else {
				if (_addedToJuggler) {
					Starling.juggler.remove(this);
					_addedToJuggler = false;
					rotation = 0;
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function playChangeTexture():void {
			TweenNano.to(this, 0.2, {width: 3, height: 3, onComplete: changeTexture});
		}

		private function changeTexture():void {
			if (!data) return;

			_image.texture = GridCellTextureFactory.getTextureByType(data.type);
			if (stage) {
				TweenNano.to(this, 0.2, {width: Layout.field.elementSize, height: Layout.field.elementSize});
			}
		}

		public function updateCount(event:* = null):void {
			if (!_data) return;

			var p:PestGridCellData = _data as PestGridCellData;
			if (_countTextField && !p) {
				_countTextField.visible = false;
				return;
			}
			if (!p) return;

			if (!_countTextField) {
				const bg:Image = Assets.getImage(AssetList.Tools_amount_components_on);
				_countTextField = new TextFieldBackground(AssetList.font_xsmall_milk_bold, bg, true, true);
				_countTextField.x = Layout.field.elementSize - bg.width;
				_countTextField.y = Layout.field.elementSize - bg.height;
			}

			_countTextField.text = String(p.turnsLeft);
			_countTextField.visible = true;

			addChild(_countTextField);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
	}
}

class ConstructorPrivater {
}