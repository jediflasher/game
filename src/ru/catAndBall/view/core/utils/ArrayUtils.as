package ru.catAndBall.view.core.utils {
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                08.01.15 17:03
	 */
	public class ArrayUtils {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function toVector(array:Array, vector:*):* {
			for each (var element:* in array) vector.push(element);
			return vector;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ArrayUtils() {
			super();
		}
	}
}
