package airlib.controller {

	import flash.events.EventDispatcher;
	import flash.net.SharedObject;

	import ru.airlib.view.BaseAppView;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                18.06.15 10:30
	 */
	public class BaseAppController extends EventDispatcher {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		private static var _instance:BaseAppController;

		public static function saveData():void {
			if (!_instance) return;

			_instance.saveToSharedObject();
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseAppController(appView:BaseAppView) {
			super();
			_view = appView;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get projectName():String {
			throw new Error('Must be overwritten');
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		protected var _view:BaseAppView;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function setProgress(progress:Number):void {
			if (progress == 1) {
				init();
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected function saveToSharedObject():void {
			try {

				var data:Object = getDataToSave();
				if (!data) return;

				var so:SharedObject = SharedObject.getLocal(projectName);
				so.data['game'] = data;
				so.flush();
				trace('Data saved to SharedObject ', projectName);
			} catch (error:Error) {
				//Logger.logError('Cant save data to shared object' + error);
			}
		}

		protected function getDataToSave():Object {
			return null;
		}

		protected function init():void {
		}
	}
}
