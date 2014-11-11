package ru.catAndBall.controller.screen {
	import feathers.controls.ScreenNavigator;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.craft.CraftFooterBar;
	import ru.catAndBall.view.screens.craft.ScreenCraft;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.11.14 9:14
	 */
	public class ScreenCraftController extends BaseScreenController {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenCraftController(navigator:ScreenNavigator, screen:ScreenCraft) {
			super(navigator, screen);

			events[CraftFooterBar.EVENT_BACK_CLICK] = backClick;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function backClick():void {
			navigator.showScreen(ScreenType.ROOM);
		}
	}
}
