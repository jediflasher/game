package ru.catAndBall.controller.screen {
	
	import feathers.controls.ScreenNavigator;
	import feathers.core.PopUpManager;
	
	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.controller.PurchaseController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.view.popups.ConstructionNoResourcesPopup;
	import ru.catAndBall.view.screens.construction.ConstructionItem;
	
	import starling.events.Event;
	
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

			screen.addEventListener(ConstructionItem.EVENT_BUILD_CLICK, handler_buildClick);
			screen.addEventListener(ConstructionItem.EVENT_SPEEDUP_CLICK, handler_speedUpClick);

			_popup.addEventListener(ConstructionNoResourcesPopup.EVENT_CREATE_CLICK, handler_buildForMoneyClick);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _currentBuilding:ConstructionData;

		private var _popup:ConstructionNoResourcesPopup = new ConstructionNoResourcesPopup();

		//--------------------------------------------------------------------------
		//
		//  Pricate methods
		//
		//--------------------------------------------------------------------------

		private function onPurchaseSuccess():void {
			_currentBuilding.startBuilding();
		}

		private function onPurchaseFail():void {
			PopUpManager.addPopUp(_popup);
		}

		private function onSpeedUpPurchaseSuccess():void {
			_currentBuilding.speedUp();
		}

		private function onSpeedFail():void {

		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_buildClick(event:Event):void {
			_currentBuilding = event.data as ConstructionData;
			_popup.data = _currentBuilding;

			var price:ResourceSet = _currentBuilding.nextState.price;

			if (GameData.player.resources.hasEnough(price)) {
				PurchaseController.buyResources(price, onPurchaseSuccess, onPurchaseFail);
			} else {
				PopUpManager.addPopUp(_popup);
			}
		}

		private function handler_speedUpClick(event:Event):void {
			_currentBuilding = event.data as ConstructionData;

			var price:ResourceSet = _currentBuilding.nextState.speedUpPrice;
			PurchaseController.buyResources(price, onSpeedUpPurchaseSuccess, onSpeedFail);
		}

		private function handler_buildForMoneyClick(event:*):void {
			PurchaseController.buyResources(_currentBuilding.nextState.price, onPurchaseSuccess, onPurchaseFail);
			PopUpManager.removePopUp(_popup);
		}
	}
}
