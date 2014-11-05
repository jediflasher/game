package ru.catAndBall.view.core.game.field {


	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
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
	public class BaseScreenFieldBackground extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseScreenFieldBackground(headerBg:String, fieldBg:String, elementBg1:String, elementBg2:String, topBorder:String, bottomBorder:String, wSize:int, hSize:int) {
			super();

			_headerBg = Assets.getImage(headerBg);
			_fieldBg = new TiledImage(Assets.getTexture(fieldBg));
			_elementBg1 = Assets.getImage(elementBg1);
			_elementBg2 = Assets.getImage(elementBg2);
			_topBorder = new TiledImage(Assets.getTexture(topBorder));
			_bottomBorder = new TiledImage(Assets.getTexture(bottomBorder));
			_woodBg = Assets.getImage(AssetList.Panel_components_bg_for_components);
			_sizeW = wSize;
			_sizeH = hSize;

			init();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _headerBg:Image;

		private var _fieldBg:TiledImage;

		private var _elementBg1:Image;

		private var _elementBg2:Image;

		private var _topBorder:TiledImage;

		private var _bottomBorder:TiledImage;

		private var _woodBg:Image;

		private var _sizeW:int;

		private var _sizeH:int;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function init():void {
			_headerBg.x = 0;
			_headerBg.y = 0;

			var nextY:Number = _headerBg.height;

			_topBorder.x = 0;
			_topBorder.y = nextY;
			_topBorder.width = AppProperties.appWidth;

			var h:Number = _sizeH * (_elementBg1.texture.height + Layout.fieldElementPadding) + (Layout.baseGap * 2);
			_fieldBg.touchable = false;
			_fieldBg.x = 0;
			_fieldBg.y = nextY;
			_fieldBg.setTo(h, h);

			for (var i:int = 0; i < _sizeW; i++) {
				for (var j:int = 0; j < _sizeH; j++) {
					var img:Image = (i + j % 2) ? _elementBg1 : _elementBg2;
					img.x = i * (img.texture.width + Layout.fieldElementPadding);
					img.y = j * (img.texture.height + Layout.fieldElementPadding);
					addChild(img);
				}
			}

			nextY += h;

			_bottomBorder.x = 0;
			_bottomBorder.y = nextY;
			_bottomBorder.width = AppProperties.appWidth;

			_woodBg.x = 0;
			_woodBg.y = nextY;

			addChild(_headerBg);
			addChild(_fieldBg);
			addChild(_woodBg);
			addChild(_topBorder);
			addChild(_bottomBorder);

			flatten();
		}
	}
}
