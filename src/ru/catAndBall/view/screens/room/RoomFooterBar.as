package ru.catAndBall.view.screens.room {
	import feathers.controls.Header;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.TiledImage;

	import starling.display.Button;

	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                12.10.14 11:44
	 */
	public class RoomFooterBar extends Header {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function RoomFooterBar() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _construction:Button;

		private var _mouses:Button;

		private var _bank:Button;

		private var _inventory:Button;

		private var _settings:Button;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			var bg:TiledImage = new TiledImage(Assets.getTexture(AssetList.Footer_pannel_pattern));
			bg.width = AppProperties.appWidth;
			backgroundSkin = bg;

			_construction = Assets.getButton(AssetList.Footer_home);
			_mouses = Assets.getButton(AssetList.Footer_mouse_worker);
			_bank = Assets.getButton(AssetList.Footer_bank);
			_inventory = Assets.getButton(AssetList.Footer_inventar);
			_settings = Assets.getButton(AssetList.Footer_settings);

			centerItems = new <DisplayObject>[_construction, _mouses, _bank, _inventory, _settings];
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_craftClick(event:Event):void {
			//craft
		}
	}
}
