package ru.catAndBall.view.screens.room {
	import feathers.controls.Header;
	import feathers.core.IFeathersControl;

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.TiledImage;
	import ru.catAndBall.view.core.ui.BaseFooterBar;
	import ru.catAndBall.view.core.ui.YellowButton;
	import ru.catAndBall.view.layout.Layout;

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
	public class RoomFooterBar extends BaseFooterBar {

		public static const EVENT_CONSTRUCTION_CLICK:String = 'eventConstructionClick';

		public static const EVENT_MOUSE_CLICK:String = 'eventMouseClick';

		public static const EVENT_BANK_CLICK:String = 'eventBankClick';

		public static const EVENT_INVENTORY_CLICK:String = 'eventInventoryClick';

		public static const EVENT_SETTINGS_CLICK:String = 'eventSettingsClick';

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

		private var _settings:YellowButton;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			var bg:TiledImage = new TiledImage(Assets.getTexture(AssetList.Footer_pannel_pattern));
			bg.width = AppProperties.appWidth;
			backgroundSkin = bg;

			_construction = Assets.getButton(AssetList.Footer_home);
			_construction.addEventListener(Event.TRIGGERED, handler_constructionClick);

			_mouses = Assets.getButton(AssetList.Footer_mouse_worker);
			_mouses.addEventListener(Event.TRIGGERED, handler_mouseClick);

			_bank = Assets.getButton(AssetList.Footer_bank);
			_bank.addEventListener(Event.TRIGGERED, handler_bankClick);

			_inventory = Assets.getButton(AssetList.Footer_inventar);
			_inventory.addEventListener(Event.TRIGGERED, handler_inventoryClick);

			_settings = new YellowButton(AssetList.buttons_settings);
			_settings.addEventListener(Event.TRIGGERED, handler_settingsClick);

			_items = new <DisplayObject>[_construction, _mouses, _bank, _inventory, _settings];

			super.initialize();
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_settingsClick(event:Event):void {
			dispatchEventWith(EVENT_SETTINGS_CLICK, true);
		}

		private function handler_inventoryClick(event:Event):void {
			dispatchEventWith(EVENT_INVENTORY_CLICK, true);
		}

		private function handler_bankClick(event:Event):void {
			dispatchEventWith(EVENT_BANK_CLICK, true);
		}

		private function handler_mouseClick(event:Event):void {
			dispatchEventWith(EVENT_MOUSE_CLICK, true);
		}

		private function handler_constructionClick(event:Event):void {
			dispatchEventWith(EVENT_CONSTRUCTION_CLICK, true);
		}
	}
}
