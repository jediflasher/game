package ru.catAndBall.view.layout.field {
	import flash.geom.Rectangle;

	import ru.catAndBall.AppProperties;

	import ru.catAndBall.AppProperties;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                06.11.14 17:32
	 */
	public class FieldLayout {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function FieldLayout() {
			super();
		}

		/**
		 * Размер элемента на поле
		 */
		public const elementSize:int = AppProperties.getValue(180, 130);

		/**
		 * Отступ он верхней границы поля до начала элементов
		 */
		public const elementsTopPadding:int = AppProperties.getValue(20, 10);

		/**
		 * Высота подложки счетчика компонентов на поле
		 */
		public const counterBgHeight:int = AppProperties.getValue(245, 200);

		/**
		 * Отступ самих счетчиков от верхней части панели счетчиков
 		 */
		public const countersTopPadding:int = AppProperties.getValue(30, 20);

		/**
		 * Отступ справа от счетчика
		 */
		public const counterRightPadding:int = AppProperties.getValue(20, 15);

		/**
		 * Ширина заполненного на 100% каунтера
		 */
		public const counterProgressMaxHeight:int = AppProperties.getValue(214, 150);

		/**
		 * Размеры scale3Grid фона счетчика компонентов на поле
		 */
		public const counterBgScaleGridSizes:Array = AppProperties.getValue([33, 46], [23, 27]);

		/**
		 * Размеры scale3Grid прогрессбара счетчика компонентов на поле
		 */
		public const counterMilkScaleGridSizes:Array = AppProperties.getValue([5, 1], [5, 1]);

		/**
		 * Размеры и координаты подложки поля
		 */
		public const fieldBgBounds:Rectangle = AppProperties.getValue(new Rectangle(0, 168, AppProperties.baseWidth, 1313), new Rectangle(0, 165, AppProperties.baseWidth, 1316));

		/**
		 * Y координата счетчиков поля
		 */
		public const countersY:int = AppProperties.getValue(1480, 1200);

		/**
		 * Y координата кошки, обозначающей количество оставшихся ходов
		 */
		public const progressCatY:int = AppProperties.getValue(50, 30);

		/**
		 * Y координата клубка, обозначающего количество оставшихся ходов
		 */
		public const progressBallY:int = AppProperties.getValue(90, 30);

		/**
		 * Y координата линии, обозначающей количество оставшихся ходов
		 */
		public const progresslineY:int = AppProperties.getValue(130, 100);

	}
}
