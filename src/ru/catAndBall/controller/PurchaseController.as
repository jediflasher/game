package ru.catAndBall.controller {
	
	import feathers.controls.ScreenNavigator;
	
	import ru.catAndBall.controller.screen.ScreenBankController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.SimpleScreenFooterBar;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                22.11.14 13:28
	 */
	public class PurchaseController {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function init(screenNavigator:ScreenNavigator):void {
			_instance = new PurchaseController(screenNavigator);
		}

		public static function buyResources(resourceSet:ResourceSet, onSuccess:Function = null, onFail:Function = null, backToStartScreen:Boolean = true):void {
			if (_instance._resourceSet || _instance._onFail || _instance._onSuccess) throw new Error('Purchase is already in process');

			_instance.buyResources(resourceSet, onSuccess, onFail, backToStartScreen);
		}

		/**
		 * Сколько денег нужно потратить,чтобы докупить заданное количество ресурсов
		 * @param resourceSet
		 * @return
		 */
		public static function getResourceSetPrice(resourceSet:ResourceSet):int {
			var result:int = 0;

			for each (var key:String in ResourceSet.TYPES) {
				var val:int = resourceSet.get(key);
				if (val > 0) result += val;
			}

			return result;
		}

		/**
		 * Возвращает количество денег, необходимое для пропуска переданного количества секунд времени
		 * @param seconds время в секундах
		 * @return
		 */
		public static function getSkipTimePrice(seconds:int):int {
			return Math.ceil(seconds / 60);
		}

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		private static var _instance:PurchaseController;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function PurchaseController(screenNavigator:ScreenNavigator) {
			super();
			this._screenNavigator = screenNavigator;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _screenNavigator:ScreenNavigator;

		private var _resourceSet:ResourceSet;

		private var _deficitPrice:int;

		private var _onSuccess:Function;

		private var _onFail:Function;

		private const _deficitResources:ResourceSet = new ResourceSet();

		private var _startScreen:String;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function buyMoney():void {

		}

		private function buyResources(resourceSet:ResourceSet, onSuccess:Function = null, onFail:Function = null, backToStartScreen:Boolean = true):void {
			_resourceSet = resourceSet;
			_onSuccess = onSuccess;
			_onFail = onFail;

			if (backToStartScreen) _startScreen = _screenNavigator.activeScreenID;

			var pr:ResourceSet = GameData.player.resources;

			_deficitResources.clear();
			pr.getDeficit(resourceSet, _deficitResources);
			_deficitPrice = getResourceSetPrice(_deficitResources);

			if (!_deficitPrice) {
				completePurchase(true);
			} else if (pr.get(ResourceSet.MONEY) >= _deficitPrice) {
				GameData.player.money -= _deficitPrice;
				pr.add(_deficitResources);
				completePurchase(true);
			} else {
				if (_screenNavigator.activeScreenID != ScreenType.BANK) {
					var screenController:BaseScreenController = _screenNavigator.getScreen(ScreenType.BANK) as BaseScreenController;
					screenController.addEventListener(ScreenBankController.EVENT_BOUGHT, handler_moneyBough);
					screenController.view.addEventListener(SimpleScreenFooterBar.EVENT_BACK_CLICK, handler_backClick);
					screenController.previousScreen = _screenNavigator.activeScreenID;

					this._screenNavigator.showScreen(ScreenType.BANK);
				}
			}
		}

		private function completePurchase(success:Boolean):void {
			var s:Function = _onSuccess;
			var f:Function = _onFail;
			var r:ResourceSet = _resourceSet;

			_onSuccess = null;
			_onFail = null;
			_resourceSet = null;

			var screenBankController:BaseScreenController = _screenNavigator.getScreen(ScreenType.BANK) as BaseScreenController;
			screenBankController.removeEventListener(ScreenBankController.EVENT_BOUGHT, handler_moneyBough);
			screenBankController.view.removeEventListener(SimpleScreenFooterBar.EVENT_BACK_CLICK, handler_backClick);

			if (_startScreen && _screenNavigator.activeScreenID != _startScreen) _screenNavigator.showScreen(_startScreen);

			if (success) {
				var pr:ResourceSet = GameData.player.resources;
				pr.substract(r);
				if (s is Function) s.apply();
			} else {
				if (f is Function) f.apply();
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_moneyBough(event:* = null):void {
			buyResources(_resourceSet, _onSuccess, _onFail, false);
		}

		private function handler_backClick(event:* = null):void {
			completePurchase(false);
		}
	}
}
