package airlib.view {

	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;

	import starling.display.DisplayObject;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                18.06.15 10:27
	 */
	public class BaseAppView extends ScreenNavigator {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseAppView() {
			super();
		}

		public function getScreenView(screenType:String):DisplayObject {
			var item:ScreenNavigatorItem = super.getScreen(screenType);
			if (!item) return null;
			return item.screen as DisplayObject;
		}
	}
}
