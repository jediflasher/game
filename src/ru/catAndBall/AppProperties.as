//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall {

	import flash.geom.Rectangle;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                08.06.14 14:29
	 */
	public class AppProperties {

		public static var fps:int = 30;

		public static var appWidth:Number = 768;

		public static var appHeight:Number = 1024;

		public static var starlingRect:Rectangle = new Rectangle();

		public static var viewRect:Rectangle = new Rectangle();

		public static var iOS:Boolean = false;

		public static function get isHD():Boolean {
			return true;
			return starlingRect.width >= 768 && starlingRect.height >= 1024;
		}

		/**
		 *
		 * @param hdValue
		 * @param ldValue
		 * @return hdValue or ldValue * – to disable strong type check of return value
		 */
		public static function getValue(hdValue:Object, ldValue:Object):* {
			return isHD ? hdValue :ldValue;
		}
	}
}
