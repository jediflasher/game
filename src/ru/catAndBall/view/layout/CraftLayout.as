package ru.catAndBall.view.layout {
	
	import flash.geom.Point;
	
	import ru.catAndBall.AppProperties;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.11.14 19:38
	 */
	public class CraftLayout {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CraftLayout() {
			super();
		}

		public const iconSize:Number = AppProperties.getValue(310, 125);

		public const priceIconSize:int = AppProperties.getValue(170, 85);

		public const priceIconGaps:Point = AppProperties.getValue(new Point(60, 15), new Point(30, 7));

		public const priceX:int = AppProperties.getValue(1010, 160);

		public const popupPlusMinusButtonSize:int = AppProperties.getValue(100, 50);

		public const popupCounterBgSize:int = AppProperties.getValue(335, 165);

		public const popupCounterBgScaleGridSizes:Array = AppProperties.getValue([53, 10], [25, 5]);
	}
}
