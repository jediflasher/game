package ru.catAndBall.view.layout.popup {
	import flash.geom.Point;

	import ru.catAndBall.AppProperties;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.11.14 17:10
	 */
	public class InventoryLayout {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function InventoryLayout() {
			super();
		}

		public const bg2Position:Point = AppProperties.getValue(new Point(135, 353), new Point(320, 350));

		public const contentPosition:Point = AppProperties.getValue(new Point(226, 415), new Point(160, 390));

		public const closeButtonY:Number = AppProperties.getValue(47, 77);

		public const resourceIconSize:int = AppProperties.getValue(105, 50);

		public const itemsGaps:Point = AppProperties.getValue(new Point(50, 70), new Point(25, 20));

		public const titlePos:Point = AppProperties.getValue(new Point(560, 80), new Point());
	}
}
