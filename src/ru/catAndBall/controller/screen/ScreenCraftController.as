package ru.catAndBall.controller.screen {
	
	import feathers.controls.ScreenNavigator;
	import feathers.core.PopUpManager;
	
	import ru.catAndBall.controller.BaseScreenController;
	import ru.catAndBall.controller.PurchaseController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.dict.tools.ToolDict;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.core.ui.BasePopup;
	import ru.catAndBall.view.popups.CraftToolPopUp;
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

			screen.addEventListener(CraftItem.EVENT_MAKE_CLICK, handler_makeClick);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private const _makePopup:CraftToolPopUp = new CraftToolPopUp();

		private const _totalPriceResourceSet:ResourceSet = new ResourceSet();

		private var _tool:ToolDict;

		private var _count:int;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function onMakeSuccess():void {
			var pr:ResourceSet = GameData.player.resources;
			pr.addType(_tool.resourceType, _count);
		}

		private function onMakeFail():void {
			_makePopup.data = _tool;
			_makePopup.count = _count;
			PopUpManager.addPopUp(_makePopup);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_makeClick(event:Event):void {
			_makePopup.count = 0;
			_makePopup.data = event.data as ToolDict;
			_makePopup.addEventListener(CraftToolPopUp.EVENT_CREATE_CLICK, handler_createToolClick);
			_makePopup.addEventListener(BasePopup.EVENT_CLOSE_CLICK, handler_popupCloseClick);

			PopUpManager.addPopUp(_makePopup);
		}

		private function handler_popupCloseClick(event:* = null):void {
			_makePopup.removeEventListener(CraftToolPopUp.EVENT_CREATE_CLICK, handler_createToolClick);
			_makePopup.removeEventListener(BasePopup.EVENT_CLOSE_CLICK, handler_popupCloseClick);
		}

		private function handler_createToolClick(event:Event):void {
			var price:ResourceSet = _makePopup.data.price;
			_count = _makePopup.count;
			_tool = _makePopup.data;

			_totalPriceResourceSet.clear();
			_totalPriceResourceSet.add(price, _count);

			PopUpManager.removePopUp(_makePopup);
			PurchaseController.buyResources(_totalPriceResourceSet, onMakeSuccess, onMakeFail);
		}
	}
}
