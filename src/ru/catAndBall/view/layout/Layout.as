package ru.catAndBall.view.layout {
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.layout.preloader.PreloaderLayout;
	import ru.catAndBall.view.layout.room.RoomLayout;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.10.14 11:06
	 */
	public class Layout {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const baseGap:Number = AppProperties.getValue(100, 70);

		/**
		 * Расстояние между элементами на поле
		 */
		public static const fieldElementPadding:int = AppProperties.getValue(5, 3);

		/**
		 * Высота подложки счетчика компонентов на поле
		 */
		public static const fieldCounterBgHeight:int = AppProperties.getValue(83, 50);

		/**
		 * Размеры scale3Grid фона счетчика компонентов на поле
		 */
		public static const fieldCounterBgScaleGridSizes:Array = AppProperties.getValue([33, 46], [23, 27]);

		/**
		 * Размеры scale3Grid прогрессбара счетчика компонентов на поле
		 */
		public static const fieldCounterMilkScaleGridSizes:Array = AppProperties.getValue([26, 36], [21, 30]);

		/**
		 * Y координата поля
		 */
		public static const fieldFieldY:int = AppProperties.getValue(189, 120);

		/**
		 * Y координата счетчиков поля
		 */
		public static const fieldCountersY:int = AppProperties.getValue(1500, 1200);

		public static const room:RoomLayout = new RoomLayout();

		public static const preloaderLayout:PreloaderLayout = new PreloaderLayout();

		public static const bigButtonScaleGridSizes:Array = AppProperties.getValue([70, 150], [50, 100]);

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Layout() {
			super();
		}
	}
}
