package ru.catAndBall.view.screens.bank {
	
	import airlib.view.core.BaseScreen;

	import feathers.controls.Button;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.ui.BaseButton;
	import ru.catAndBall.view.core.ui.MediumGreenButton;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;
	import ru.catAndBall.view.screens.ScreenType;
	import ru.catAndBall.view.screens.SimpleScreenFooterBar;
	import ru.catAndBall.view.screens.room.header.RoomHeader;

	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                22.11.14 13:54
	 */
	public class ScreenBank extends BaseScreen {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_BUY_CLICK:String = 'buyClick';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenBank() {
			super(ScreenType.BANK);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _buyButton:MediumGreenButton;

		private var _clearButton:MediumGreenButton;

		private var _container:GridLayoutContainer;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			_buyButton = new MediumGreenButton(L.get('screen.bank.buy_button', [100]));
			_buyButton.addEventListener(Event.TRIGGERED, handler_buyClick);
			addChild(_buyButton);

			_clearButton = new MediumGreenButton(L.get('screen.bank.clear_button'));
			_clearButton.addEventListener(Event.TRIGGERED, handler_clearClick);
			addChild(_clearButton);

			_container = new GridLayoutContainer(5, Layout.baseResourceIconSize, Layout.baseResourceIconSize, 20, 20);

			for each (var type:String in ResourceSet.TYPES) {
				var counter:ResourceCounter = new ResourceCounter(type, GameData.player.resources);
				var btn:Button = new Button();
				btn.useHandCursor = true;
				btn.defaultIcon = counter;
				btn.addEventListener(Event.TRIGGERED, clickResourceButton);
				_container.addChild(btn);
			}

			addChild(_container);

			super.initialize();
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_LAYOUT)) {
				_buyButton.validate();

				_buyButton.x = AppProperties.baseWidth / 2 - _buyButton.width / 2;
				_buyButton.y = 100;

				_container.x = AppProperties.baseWidth / 2 - _container.width / 2;
				_container.y = _buyButton.y + _buyButton.height + Layout.baseGap;

				_clearButton.validate();
				_clearButton.x = AppProperties.baseWidth / 2 - _clearButton.width / 2;
				_clearButton.y = _container.y + _container.height + Layout.baseGap;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function handler_buyClick(event:Event):void {
			dispatchEventWith(EVENT_BUY_CLICK);
		}

		private function clickResourceButton(event:Event):void {
			var btn:BaseButton = event.target as BaseButton;
			GameData.player.resources.addType(String(btn.data), 10);
		}

		private function handler_clearClick(event:Event):void {
			GameData.player.resources.clear();
		}
	}
}
