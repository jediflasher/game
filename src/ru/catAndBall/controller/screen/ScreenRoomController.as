//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.screen {

	import feathers.controls.ScreenNavigator;
	import feathers.core.PopUpManager;
	import feathers.core.PopUpManager;

	import ru.catAndBall.AppController;

	import ru.catAndBall.controller.BaseScreenController;

	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.controller.PurchaseController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.Construction;
	import ru.catAndBall.view.core.ui.BasePopup;
	import ru.catAndBall.view.core.ui.SuperPopup;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.popups.InventoryPopup;
	import ru.catAndBall.view.popups.StartFieldPaidPopup;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.room.footer.RoomFooterBar;
	import ru.catAndBall.view.screens.room.ScreenRoom;

	import starling.display.Image;

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
			events[ScreenRoom.EVENT_RUG_CLICK] = rugFieldClick;
			events[ScreenRoom.EVENT_BALLS_CLICK] = ballsClick;

			events[RoomFooterBar.EVENT_MOUSE_CLICK] = ScreenType.COMMODE_CRAFT;
			events[RoomFooterBar.EVENT_CONSTRUCTION_CLICK] = ScreenType.CONSTRUCTION;
			events[RoomFooterBar.EVENT_BANK_CLICK] = bankClick;
			events[RoomFooterBar.EVENT_INVENTORY_CLICK] = inventoryClick;
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

		private var _popupFieldComplete:SuperPopup;

		private var _popupFieldStart:SuperPopup;

		private var _popupPaidFieldStart:SuperPopup;

		private var _inventory:InventoryPopup;

		private var _completedGrid:GridData;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public function fieldComplete(fieldData:GridData):void {
			_completedGrid = fieldData;

			if (!_popupFieldComplete) {
				_popupFieldComplete = new SuperPopup();
			}

			var exp:int = fieldData.collectedResourceSet.get(ResourceSet.EXPERIENCE);
			_popupFieldComplete.resourceSet = fieldData.collectedResourceSet;
			_popupFieldComplete.title = L.get('finish_field_popup.balls.title');
			_popupFieldComplete.desc = exp ? L.get('finish_field_popup.balls.desc', [exp]) : null;
			_popupFieldComplete.buttonLabel = L.get('finish_field_popup.balls.take');
			_popupFieldComplete.icon = Assets.getImage(AssetList.Room_tangles1);
			_popupFieldComplete.showClose = false;
			_popupFieldComplete.addEventListener(BasePopup.EVENT_BUTTON_CLICK, handler_completeBallsClick);

			PopUpManager.addPopUp(_popupFieldComplete);

			GameData.player.resources.add(_completedGrid.collectedResourceSet);
			AppController.saveData();
		}

		public function fieldCancel(fieldData:GridData):void {
			navigator.showScreen(ScreenType.ROOM);
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected override function added():void {
			super.added();

			view.addEventListener(Construction.EVENT_TOUCH, handler_buildingTouch);
		}

		protected override function removed():void {
			view.removeEventListener(Construction.EVENT_TOUCH, handler_buildingTouch);
			super.removed();
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function ballsClick():void {
			if (!_popupFieldStart) _popupFieldStart = new SuperPopup();

			_popupFieldStart.title = L.get('start_field_popup.balls.title');
			_popupFieldStart.buttonLabel = L.get('start_field_popup.balls.start');
			_popupFieldStart.desc = L.get('start_field_popup.balls.desc');
			_popupFieldStart.icon = Assets.getImage(AssetList.Room_tangles1);
			_popupFieldStart.showClose = true;
			_popupFieldStart.resourceSet = GameData.player.ballsField.settings.price;
			_popupFieldStart.addEventListener(BasePopup.EVENT_BUTTON_CLICK, handler_startBallsClick);

			PopUpManager.addPopUp(_popupFieldStart);
		}

		private function rugFieldClick():void {
			if (!_popupPaidFieldStart) _popupPaidFieldStart = new StartFieldPaidPopup();

			_popupPaidFieldStart.title = L.get('start_field_popup.rug.title');
			_popupPaidFieldStart.desc = L.get('start_field_popup.rug.desc');
			_popupPaidFieldStart.icon = Assets.getImage(AssetList.popup_carpet_icon);
			_popupPaidFieldStart.showClose = true;
			_popupPaidFieldStart.resourceSet = GameData.player.rugField.settings.price;
			_popupPaidFieldStart.addEventListener(BasePopup.EVENT_BUTTON_CLICK, handler_startRugClick);

			PopUpManager.addPopUp(_popupPaidFieldStart);
		}

		private function inventoryClick():void {
			if (!_inventory) {
				_inventory = new InventoryPopup();
				_inventory.addEventListener(InventoryPopup.EVENT_CLOSE_CLICK, handler_closeInventoryClick);
			}

			PopUpManager.addPopUp(_inventory);
		}

		private function bankClick():void {
			var screenBankController:BaseScreenController = navigator.getScreen(ScreenType.BANK) as BaseScreenController;
			screenBankController.previousScreen = ScreenType.ROOM;
			navigator.showScreen(ScreenType.BANK);
		}

		private function onRugRecourseReady():void {
			navigator.showScreen(ScreenType.RUG_FIELD);
		}

		private function onRugRecourseFailed():void {
			rugFieldClick();
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------

		private function handler_buildingTouch(event:Event):void {
			var building:Construction = event.target as Construction;
			var data:ConstructionData = building.data;

			if (data.canCollectBonus) {
				var bonus:ResourceSet = data.bonus;
				GameData.player.resources.add(bonus);
				data.collectBonus();

				var fromX:int = building.x;
				var fromY:int = building.y;
				(view as ScreenRoom).drop(bonus, fromX, fromY);
			}
		}

		private function handler_startBallsClick(event:Event):void {
			PopUpManager.removePopUp(_popupFieldStart);
			navigator.showScreen(ScreenType.BALLS_FIELD);
		}

		private function handler_startRugClick(event:Event):void {
			PurchaseController.buyResources(_popupPaidFieldStart.resourceSet, onRugRecourseReady, onRugRecourseFailed, false);
			PopUpManager.removePopUp(_popupPaidFieldStart);
		}

		private function handler_completeBallsClick(event:Event):void {
			PopUpManager.removePopUp(_popupFieldComplete);
		}

		private function handler_closeInventoryClick(event:Event):void {
			PopUpManager.removePopUp(_inventory);
		}
	}
}
