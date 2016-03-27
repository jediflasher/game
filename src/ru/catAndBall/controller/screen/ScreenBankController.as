package ru.catAndBall.controller.screen {
	
	import airlib.view.core.BaseScreen;

	import feathers.controls.ScreenNavigator;

	import flash.events.Event;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.screens.bank.ScreenBank;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                22.11.14 19:16
	 */
	public class ScreenBankController extends BaseScreenController {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_BOUGHT:String = 'eventMoneyBought';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenBankController(navigator:ScreenNavigator, screen:BaseScreen) {
			super(navigator, screen);

			events[ScreenBank.EVENT_BUY_CLICK] = buyClick;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function buyClick():void {
			GameData.player.resources.addType(ResourceSet.MONEY, 100);
			if (hasEventListener(EVENT_BOUGHT)) dispatchEvent(new Event(EVENT_BOUGHT));
		}
	}
}
