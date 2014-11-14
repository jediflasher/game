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

		public const bgScaleGridSizes:Array = AppProperties.getValue([540, 48], [250, 24]);

		/**
		 * Центральная точка изображения относительно попапа
		 */
		public const iconPosition:Point = AppProperties.getValue(new Point(544, 260), new Point(500, 200));

		/**
		 * Y координата контента относительно попапа
		 */
		public const contentY:int = AppProperties.getValue(450, 230);

		public const contentWidth:Number = AppProperties.getValue(717, 360);

		/**
		 * Расстояние по оси Y между объектами контента
		 */
		public const contentGap:int = AppProperties.getValue(30, 10);

		/**
		 * Центральная точка кнопки закрытия
		 */
		public const closeButtonPosition:Point = AppProperties.getValue(new Point(970, 195), new Point(480, 97));

		public const bgBottomHeight:int = AppProperties.getValue(130, 100);
	}
}
