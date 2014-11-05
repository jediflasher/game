//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.utils {

	import com.greensock.TweenNano;

	import feathers.core.PopUpManager;

	import flash.utils.getTimer;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                19.07.14 13:06
	 */
	public class TimeUtil {

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		private static const ZERO:String = '0';

		private static const COLON:String = ':';

		private static const instance:TimeUtil = new TimeUtil();

		//--------------------------------------------------------------------------
		//
		//  Class properties
		//
		//--------------------------------------------------------------------------

		/**
		 * Timestamp in seconds
		 */
		public static function get now():Number {
			return instance.now;
		}

		/**
		 * Formats time like 12:39:04
		 */
		public static function stringify(seconds:Number):String {
			var delta:Number = seconds / TimeInterval.HOUR;
			var h:int = int(delta);
			seconds -= h * TimeInterval.HOUR;

			delta = seconds / TimeInterval.MINUTE;
			var m:int = int(delta);
			seconds -= m * TimeInterval.MINUTE;

			seconds = int(seconds);

			var hs:String = String(h < 10 ? ZERO + h : h);
			var ms:String = String(m < 10 ? ZERO + m : m);
			var ss:String = String(seconds < 10 ? ZERO + seconds : seconds);

			return hs + COLON + ms + COLON + ss;
		}

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function TimeUtil() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _diffTime:Number;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get now():Number {
			var tSec:Number = int(getTimer() / 1000);
			if (_diffTime != _diffTime) { // isNaN check
				var date:Date = new Date();
				_diffTime = date.time - tSec;
			}

			return _diffTime + tSec;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
}
