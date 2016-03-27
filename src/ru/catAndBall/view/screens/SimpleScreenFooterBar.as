package ru.catAndBall.view.screens {
	
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.ui.BaseFooterBar;
	import ru.catAndBall.view.core.ui.YellowButton;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.11.14 8:58
	 */
	public class SimpleScreenFooterBar extends BaseFooterBar {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_BACK_CLICK:String = 'eventBackClick';

		public static const EVENT_SETTINGS_CLICK:String = 'eventSettingsClick';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function SimpleScreenFooterBar() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _backButton:YellowButton;

		private var _settings:YellowButton;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			_backButton = new YellowButton(AssetList.buttons_back);
			_backButton.addEventListener(Event.TRIGGERED, handler_backClick);
			leftItems = new <DisplayObject>[_backButton];

			_settings = new YellowButton(AssetList.buttons_settings);
			_settings.addEventListener(Event.TRIGGERED, handler_settingsClick);
			rightItems = new <DisplayObject>[_settings];

			super.initialize();
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_backClick(event:Event):void {
			dispatchEventWith(EVENT_BACK_CLICK, true);
		}

		private function handler_settingsClick(event:Event):void {
			dispatchEventWith(EVENT_SETTINGS_CLICK, true);
		}
	}
}
