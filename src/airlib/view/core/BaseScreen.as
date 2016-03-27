package airlib.view.core {

	import feathers.controls.IScreen;
	import feathers.core.FeathersControl;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                21.06.15 18:02
	 */
	public class BaseScreen extends FeathersControl implements IScreen {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseScreen(screenType:String) {
			super();
			screenID = screenType;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var _screenID:String;

		public function get screenID():String {
			return this._screenID;
		}

		public function set screenID(value:String):void {
			this._screenID = value;
		}

		protected var _owner:Object;

		public function get owner():Object {
			return this._owner;
		}

		public function set owner(value:Object):void {
			this._owner = value;
		}
	}
}
