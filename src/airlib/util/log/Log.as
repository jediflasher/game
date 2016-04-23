package airlib.util.log {

	import airlib.AppProperties;

	import starling.utils.SystemUtil;
	import starling.utils.formatString;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                30.01.2016 16:47
	 */
	public class Log {

//		private static var _instance:RavenClient;

		public static const ERROR:String = 'error';

		private static var _log:String = '';

		private static var _tags:Object = {};

		public static function init():void {
			//_instance = new RavenClient('http://1260ed0c8ee941cfa7c078b547d0d516:74637c7b794f40f6b1058367e088c782@sentry.thequestion.ru/13');
		}

		public static function info(target:Object, message:String, args:Array = null):void {
			if (args) {
				args.unshift(message);
				message = formatString.apply(null, args);
			}

			add(target + ': ' + message);
		}

		public static function error(target:Object, message:String, args:Array = null):void {
			if (args) {
				args.unshift(message);
				message = formatString.apply(null, args);
			}
			add(target + ': ' + message);
			sendFull(target + ': ' + message, Log.ERROR);
		}

		public static function markError(target:Object, message:String, args:Array = null):void {
			if (args) {
				args.unshift(message);
				message = formatString.apply(null, args);
			}
			add(target + ': ' + message);
			sendMessage(message, String(target), Log.ERROR);
		}

		public static function captureError(error:Error):void {
			var e:String = error.name + ':' + error.message;
			add(e + '\n' + error.getStackTrace());
			sendFull(e, Log.ERROR);
		}

		public static function sendFull(name:String, logLevel:String):void {
			if (AppProperties.DEV) return;

			var tags:Object = AppProperties.asObject();
			tags['platform'] = SystemUtil.platform;
			tags['fpVersion'] = SystemUtil.version;
//			_instance.setTags(tags);
			sendMessage(name + '\n' + _log, name, logLevel);
		}

		private static function sendMessage(log:String, name:String, logLevel:String):void {
			// todo send to URL
		}

		private static function add(str:String):void {
			_log += str + '\n';
			trace(str);
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Log() {
			super();
		}


	}
}
