package ru.catAndBall.view.core.ui {
	import feathers.controls.Header;
	import feathers.controls.supportClasses.LayoutViewPort;
	import feathers.core.IFeathersControl;
	import feathers.display.TiledImage;

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.DisplayObject;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.11.14 8:52
	 */
	public class BaseFooterBar extends Header {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseFooterBar() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			var bg:TiledImage = new TiledImage(Assets.getTexture(AssetList.Footer_footerPannel));
			bg.width = AppProperties.baseWidth;
			backgroundSkin = bg;

			var r:Rectangle = AppProperties.viewRect;
			paddingLeft = paddingRight = r.x + Layout.baseGap;

			gap = Layout.baseGap;
			paddingTop = 50;

			super.initialize();
		}
	}
}
