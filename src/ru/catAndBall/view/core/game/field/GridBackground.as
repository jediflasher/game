package ru.catAndBall.view.core.game.field {
	
	
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.TiledImage;
	import ru.catAndBall.view.layout.Layout;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.11.14 13:12
	 */
	public class GridBackground extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function GridBackground(fieldBg:String, elementBg1:String, elementBg2:String, wSize:int, hSize:int) {
			super();

			_fieldBg = new TiledImage(Assets.getTexture(fieldBg));
			_elementBg1 = elementBg1;
			_elementBg2 = elementBg2;

			elementSize = Assets.getTexture(elementBg1).width;

			_sizeW = wSize;
			_sizeH = hSize;

			init();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _fieldBg:TiledImage;

		private var _elementBg1:String;

		private var _elementBg2:String;

		private var _sizeW:int;

		private var _sizeH:int;

		public var startX:Number = 155;

		public var startY:Number = 45;

		public var elementSize:Number;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function init():void {
			_fieldBg.touchable = false;
			_fieldBg.x = 0;
			_fieldBg.y = 0;
			_fieldBg.setTo(Layout.field.fieldBgBounds.width, Layout.field.fieldBgBounds.height);

			addChild(_fieldBg);

			for (var i:int = 0; i < _sizeW; i++) {
				for (var j:int = 0; j < _sizeH; j++) {
					var img:Image = (i + j) % 2 ? Assets.getImage(_elementBg1) : Assets.getImage(_elementBg2);
					img.width = img.height = Layout.field.elementSize;
					img.x = startX + (i * img.texture.width);
					img.y = startY + (j * img.texture.height);
					addChild(img);
				}
			}

			flatten();
		}
	}
}
