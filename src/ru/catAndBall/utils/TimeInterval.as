////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 CrazyPanda LLC
//
////////////////////////////////////////////////////////////////////////////////

package ru.catAndBall.utils {


	/**
	 * @author                    etc
	 * @version                    1.0
	 * @playerversion            Flash 10
	 * @langversion                3.0
	 * @date                    Dec 15, 2011
	 */
	public final class TimeInterval {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const SECOND:Number = 1;

		public static const MINUTE:Number = 60 * SECOND;

		public static const HOUR:Number = 60 * MINUTE;

		public static const ROUND_THE_CLOCK:Number = 24 * HOUR;

		public static const WEEK:Number = 7 * ROUND_THE_CLOCK;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function TimeInterval() {
			super();
		}
	}
}