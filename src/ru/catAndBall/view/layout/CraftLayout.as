package ru.catAndBall.view.layout {
	import flash.geom.Point;
	import flash.geom.Rectangle;

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

		public const titlePos:Point = AppProperties.getValue(new Point(115, 36), new Point(78, 27));

		public const descBounds:Rectangle = AppProperties.getValue(new Rectangle(115, 125, 470, 290), new Rectangle(78, 27, 235, 180));

		public const iconPos:Point = AppProperties.getValue(new Point(620, 35), new Point(78, 27));

		public const tabGap:int = AppProperties.getValue(15, 7);

		public const iconSize:Number = AppProperties.getValue(310, 125);

		public const priceIconSize:int = AppProperties.getValue(170, 85);

		public const priceIconGaps:Point = AppProperties.getValue(new Point(60, 15), new Point(30, 7));

		public const priceX:int = AppProperties.getValue(1010, 160);
	}
}
