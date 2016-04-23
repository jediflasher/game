//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.screen {
	
	import feathers.controls.ScreenNavigator;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.mainMenu.ScreenMenu;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                19.07.14 12:32
	 */
	public class ScreenMenuController extends BaseScreenController {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenMenuController(navigator:ScreenNavigator, screen:ScreenMenu) {
			super(navigator, screen);
			setScreenIDForEvent(ScreenMenu.EVENT_GAME_CLICK, ScreenType.ROOM);
		}
	}
}
