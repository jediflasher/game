package ru.catAndBall.view.layout {
	
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.layout.field.FieldLayout;
	import ru.catAndBall.view.layout.popup.InventoryLayout;
	import ru.catAndBall.view.layout.popup.PopupLayout;
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

		public static const baseGap:int = AppProperties.getValue(50, 50); 

		public static const headerHeight:Number = 173;

		public static const footerHeight:Number = 173;

		public static const baseResourceIconSize:int = AppProperties.getValue(125, 125);

		public static const popup:PopupLayout = new PopupLayout();

		public static const room:RoomLayout = new RoomLayout();

		public static const field:FieldLayout = new FieldLayout();

		public static const inventory:InventoryLayout = new InventoryLayout();

		public static const craft:CraftLayout = new CraftLayout();

		public static const mediumButtonScaleGridSizes:Array = AppProperties.getValue([50, 48], [50, 48]);

		public static const smallButtonScaleGridSizes:Array = AppProperties.getValue([35, 32], [35, 32]);

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
