//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.mainMenu {

	import feathers.controls.Button;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.core.ui.BigGreenButton;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.screens.BaseScreen;

	import starling.events.Event;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                07.06.14 19:14
	 */
	public class ScreenMenu extends BaseScreen {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_GAME_CLICK:String = 'continueClick';

		public static const EVENT_SETTINGS_CLICK:String = 'exitClick';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenMenu(data:BaseScreenData) {
			super(data, "preloader");
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _buttonStart:Button;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_buttonStart = new BigGreenButton(L.get("Start game"));
			_buttonStart.addEventListener(Event.TRIGGERED, handler_startClick);

			addChild(_buttonStart);
		}

		protected override function draw():void {
			super.draw();

			_buttonStart.x = AppProperties.appWidth / 2 - _buttonStart.width / 2;
			_buttonStart.y = AppProperties.appHeight * 0.7;
		}

//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_startClick(event:Event):void {
			dispatchEventWith(EVENT_GAME_CLICK);
		}
	}
}
