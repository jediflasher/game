package ru.catAndBall.view.core.game {
	import feathers.controls.Button;

	import ru.catAndBall.AppProperties;

	import ru.catAndBall.AppProperties;

	import ru.catAndBall.AppProperties;

	import ru.catAndBall.data.game.ResourceSet;

	import ru.catAndBall.view.assets.AssetList;

	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.11.14 10:55
	 */
	public class PriceButtonDecorator {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const BIG_ICON_SIZE:int = AppProperties.getValue(115, 55);

		public static const MEDIUM_ICON_SIZE:int = AppProperties.getValue(55, 23);

		public static const SMALL_ICON_SIZE:int = AppProperties.getValue(20, 10);

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function PriceButtonDecorator(button:Button, labelKeyHasPrice:String = null, labelKeyNoPrice:String = null, iconSize:int = 0) {
			super();

			this.button = button;
			this.button.gap = Layout.baseGap / 2;
			_iconSize = iconSize || MEDIUM_ICON_SIZE;
			_labelKeyPrice = labelKeyHasPrice;
			_labelKeyNoPrice = labelKeyNoPrice;

			updateButton();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _iconSize:int;

		private var _labelKeyPrice:String;

		private var _labelKeyNoPrice:String;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _price:int;

		public function get price():int {
			return _price;
		}

		public function set price(value:int):void {
			if (_price == value) return;

			_price = value;
			updateButton();
		}

		public var button:Button;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateButton():void {
			if (_price > 0) {
				button.iconPosition = Button.ICON_POSITION_RIGHT;
				button.defaultIcon = new ResourceImage(ResourceSet.MONEY, _iconSize);
				if (_labelKeyPrice) button.label = L.get(_labelKeyPrice, [_price]);
				else button.label = "";
			} else {
				button.defaultIcon = null;
				if (_labelKeyNoPrice) button.label = L.get(_labelKeyNoPrice);
				else button.label = "";
			}
		}
	}
}
