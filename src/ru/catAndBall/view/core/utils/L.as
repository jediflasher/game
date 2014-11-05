package ru.catAndBall.view.core.utils {
	import ru.catAndBall.utils.str;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.09.14 21:55
	 */
	public class L {

		public static function get(text:String, args:Array = null):String {
			text = str(text, args);
			return text;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function L() {

		}
	}
}
