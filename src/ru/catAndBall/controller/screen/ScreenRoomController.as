//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.screen {

	import feathers.controls.ScreenNavigator;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.buildings.BuildingData;
	import ru.catAndBall.view.core.game.Building;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.room.ScreenRoom;

	import starling.events.Event;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                19.07.14 14:28
	 */
	public class ScreenRoomController extends BaseScreenController {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenRoomController(navigator:ScreenNavigator, screen:ScreenRoom) {
			super(navigator, screen);
			events[ScreenRoom.EVENT_COMMODE_CLICK] = ScreenType.COMMODE_CRAFT;
			events[ScreenRoom.EVENT_RUG_CLICK] = ScreenType.RUG_FIELD;
			events[ScreenRoom.EVENT_BALLS_CLICK] = ScreenType.BALLS_FIELD;
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


		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		protected override function added():void {
			super.added();
			view.addEventListener(Building.EVENT_TOUCH, handler_buildingTouch);
		}

		protected override function removed():void {
			view.removeEventListener(Building.EVENT_TOUCH, handler_buildingTouch);
			super.removed();
		}

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


		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------

		private function handler_buildingTouch(event:Event):void {
			var building:Building = event.target as Building;
			var data:BuildingData = building.data;

			if (data.canCollectBonus) {
				var bonus:ResourceSet = data.bonus;
				GameData.player.resources.add(bonus);
				data.collectBonus();

				var fromX:int = building.x;
				var fromY:int = building.y;
				(view as ScreenRoom).drop(bonus, fromX, fromY);
			}
		}
	}
}
