package airlib.util.localization {

	import airlib.util.log.info;

	import starling.utils.formatString;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                30.06.15 23:01
	 */
	public class Localization {

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		private static var _dict:Object;

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function init(dict:Object):void {
			_dict = dict;
		}

		public static function make(key:String, args:Array = null):String {
			if (!_dict) throw 'Not initialized';

			if (!(key in _dict)) {
				info('Localization.make', 'no key {0}', [key]);
				return key;
			} else {
				var valStr:String = _dict[key];
				if (args) {
					return formatString.apply(null, [valStr].concat(args));
				} else {
					return valStr;
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Localization() {
			super();
		}
	}
}
