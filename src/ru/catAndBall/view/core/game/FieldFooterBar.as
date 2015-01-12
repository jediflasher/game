//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game {

	import feathers.controls.Header;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.TiledImage;
	import ru.catAndBall.view.core.ui.BaseFooterBar;
	import ru.catAndBall.view.core.ui.YellowButton;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 21:05
	 */
	public class FieldFooterBar extends BaseFooterBar {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_TOOLS_CLICK:String = 'eventToolsClick';

		public static const EVENT_BACK_CLICK:String = 'eventBackClick';

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function FieldFooterBar() {
			super();
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _back:YellowButton;

		private var _tools:Button;

		private var _settings:YellowButton;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {
			_back = new YellowButton(AssetList.buttons_back);
			_back.addEventListener(Event.TRIGGERED, handler_backClick);

			_tools = Assets.getButton(AssetList.panel_tools_tools_footer_icon);
			_tools.addEventListener(Event.TRIGGERED, handler_toolsClick);

			_settings =new YellowButton(AssetList.buttons_settings);

			leftItems = new <DisplayObject>[_back];
			centerItems = new <DisplayObject>[_tools];
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

		private function handler_toolsClick(event:Event):void {
			dispatchEventWith(EVENT_TOOLS_CLICK);
		}
	}
}
