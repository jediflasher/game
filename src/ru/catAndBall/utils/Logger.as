package ru.catAndBall.utils {
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.11.14 15:40
	 */
	public class Logger {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function log(str:String):void {
			trace(str);
		}

		public static function logError(error:String):void {
			trace ('error: ' + error);
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Logger() {
			super();
		}
	}
}
