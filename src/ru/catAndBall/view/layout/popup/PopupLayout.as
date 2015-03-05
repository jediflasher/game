package ru.catAndBall.view.layout.popup {
	import flash.geom.Point;

	import ru.catAndBall.AppProperties;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                08.11.14 11:43
	 */
	public class PopupLayout {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function PopupLayout() {
			super();
		}

		/**
		 * Центральная точка изображения относительно попапа
		 */
		public const iconPosition:Point = AppProperties.getValue(new Point(544, 260), new Point(544, 260));

		/**
		 * Y координата контента относительно попапа
		 */
		public const topYOffset:int = AppProperties.getValue(50, -30);

		public const contentWidth:Number = AppProperties.getValue(717, 360);

		/**
		 * Расстояние по оси Y между объектами контента
		 */
		public const contentGap:int = AppProperties.getValue(30, 10);

		/**
		 * Центральная точка кнопки закрытия
		 */
		public const closeButtonPosition:Point = AppProperties.getValue(new Point(890, 160), new Point(480, 97));
	}
}
