package airlib.util.log {

	import ru.airlib.AppProperties;
	import ru.airlib.AppProperties;

	import scopart.raven.RavenClient;

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

		private static var _instance:RavenClient;

		private static var _log:String = '';

		private static var _tags:Object = {};

		public static function init():void {
			_instance = new RavenClient('http://1260ed0c8ee941cfa7c078b547d0d516:74637c7b794f40f6b1058367e088c782@sentry.thequestion.ru/13');
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
			flush(target + ': ' + message, RavenClient.ERROR);
		}

		public static function markError(target:Object, message:String, args:Array = null):void {
			if (args) {
				args.unshift(message);
				message = formatString.apply(null, args);
			}
			add(target + ': ' + message);
			_instance.setTags(_tags);
			if (!AppProperties.DEV) _instance.captureMessage(message, String(target), RavenClient.ERROR);
		}

		public static function captureError(error:Error):void {
			var e:String = error.name + ':' + error.message;
			add(e + '\n' + error.getStackTrace());
			flush(e, RavenClient.ERROR);
		}

		public static function flush(name:String, logLevel:int):void {
			if (AppProperties.DEV) return;

			var tags:Object = AppProperties.asObject();
			tags['platform'] = SystemUtil.platform;
			tags['fpVersion'] = SystemUtil.version;
			_instance.setTags(tags);
			_instance.captureMessage(name + '\n' + _log, name, logLevel);
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
