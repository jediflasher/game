package ru.catAndBall.view.layout {
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.layout.field.FieldLayout;
	import ru.catAndBall.view.layout.popup.InventoryLayout;
	import ru.catAndBall.view.layout.popup.PopupLayout;
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

		public static const baseGap:int = AppProperties.getValue(50, 30);

		public static const baseResourceiconSize:int = AppProperties.getValue(125, 90);

		public static const popup:PopupLayout = new PopupLayout();

		public static const room:RoomLayout = new RoomLayout();

		public static const field:FieldLayout = new FieldLayout();

		public static const preloaderLayout:PreloaderLayout = new PreloaderLayout();

		public static const inventory:InventoryLayout = new InventoryLayout();

		public static const craft:CraftLayout = new CraftLayout();

		public static const bigButtonScaleGridSizes:Array = AppProperties.getValue([70, 176], [50, 100]);

		public static const mediumButtonScaleGridSizes:Array = AppProperties.getValue([50, 135], [50, 100]);

		public static const smallButtonScaleGridSizes:Array = AppProperties.getValue([40, 112], [50, 100]);

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
