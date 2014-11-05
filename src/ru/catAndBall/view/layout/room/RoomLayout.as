package ru.catAndBall.view.layout.room {
	import flash.geom.Point;

	import ru.catAndBall.AppProperties;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.10.14 11:14
	 */
	public class RoomLayout {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function RoomLayout() {
			super();
		}

		public const catHouse:Point = AppProperties.getValue(new Point(80, 1206), new Point(80, 1206));

		public const granny:Point = AppProperties.getValue(new Point(804, 537), new Point(804, 537));

		public const window:Point = AppProperties.getValue(new Point(384, 240), new Point(384, 240));

		public const rug:Point = AppProperties.getValue(new Point(300, 1115), new Point(300, 1115));

		public const commode:Point = AppProperties.getValue(new Point(5, 610), new Point(5, 610));

		public const cat:Point = AppProperties.getValue(new Point(227, 1236), new Point(227, 1236));

		public const tangles:Point = AppProperties.getValue(new Point(1070, 1208), new Point(1070, 1208));

		public const headerIconSize:int = AppProperties.getValue(76, 50);
	}
}

/*
 бабушка 804х537
 кошка 227х1236
 комод 138х610
 кошкин дом 107х1215
 клубки 1070х1208
 ковёр 299х1120
 окно 384х240
 */