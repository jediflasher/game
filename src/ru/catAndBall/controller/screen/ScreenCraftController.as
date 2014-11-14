package ru.catAndBall.controller.screen {
	import feathers.controls.ScreenNavigator;
	import feathers.core.PopUpManager;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.data.dict.tools.ToolDict;
	import ru.catAndBall.view.popups.CraftToolPopUp;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.craft.CraftFooterBar;
	import ru.catAndBall.view.screens.craft.CraftItem;
	import ru.catAndBall.view.screens.craft.ScreenCraft;

	import starling.events.Event;

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

			screen.addEventListener(CraftItem.EVENT_MAKE_CLICK, handler_makeClick);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private const _makePopup:CraftToolPopUp = new CraftToolPopUp();

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function makeClick():void {

		}

		private function backClick():void {
			navigator.showScreen(ScreenType.ROOM);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_makeClick(event:Event):void {
			_makePopup.data = event.data as ToolDict;
			PopUpManager.addPopUp(_makePopup);
		}
	}
}
