package ru.catAndBall.controller.screen {
	import feathers.controls.ScreenNavigator;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.view.screens.BaseScreen;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.11.14 13:37
	 */
	public class ScreenConstructionController extends BaseScreenController {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenConstructionController(navigator:ScreenNavigator, screen:BaseScreen) {
			super(navigator, screen);
		}
	}
}
