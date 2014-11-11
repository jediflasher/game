package ru.catAndBall.view.core.ui {
	import feathers.controls.Button;

	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;

	import starling.display.Image;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.11.14 22:06
	 */
	public class YellowButton extends Button {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function YellowButton(icon:String) {
			super();

			var img:Image = Assets.getImage(AssetList.buttons_button);
			hoverSkin = img;
			defaultSkin = Assets.getImage(AssetList.buttons_button_on);
			disabledSkin = Assets.getImage(AssetList.buttons_button_off);

			_icon = Assets.getImage(icon);
			//_icon.x = img.texture.width / 2;
			//_icon.y = img.texture.height / 2;

			_w = Math.max(img.texture.width, _icon.texture.width);
			_h = Math.max(img.texture.height, _icon.texture.height);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _icon:Image;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _w:Number;

		public override function get width():Number {
			return _w;
		}

		private var _h:Number;

		public override function get height():Number {
			return _h;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			addChild(_icon);
		}
	}
}
