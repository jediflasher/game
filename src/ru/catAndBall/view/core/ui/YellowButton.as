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

			var img:Image = Assets.getImage(AssetList.button);
			hoverSkin = img;
			defaultSkin = Assets.getImage(AssetList.button_on);
			disabledSkin = Assets.getImage(AssetList.button_off);

			_icon = Assets.getImage(icon);
			_icon.x = img.texture.width / 2 - _icon.texture.width / 2;
			_icon.y = img.texture.height / 2 - _icon.texture.height / 2;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _icon:Image;

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
