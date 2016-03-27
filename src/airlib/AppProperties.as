package airlib {

	import flash.geom.Rectangle;

	import starling.utils.formatString;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                18.06.15 9:29
	 */
	public class AppProperties {

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		public static var fps:int = 60;

		public static var baseWidth:Number = 768;

		public static var baseHeight:Number = 1024;

		public static var stageWidth:Number;

		public static var stageHeight:Number;

		public static var starlingRect:Rectangle = new Rectangle();

		public static var viewRect:Rectangle = new Rectangle();

		public static var iOS:Boolean = false;

		public static var isWeb:Boolean = false;

		public static var DEV:Boolean = false;

		public static var absoluteUrl:String = 'http://knightsnroses.com';

		public static var workspaceScale:Number = 1;

		private static var _textureScaleFactor:Number = -1;

		public static function get textureScaleFactor():Number {
			if (_textureScaleFactor == -1) {
				if (stageWidth < 400) _textureScaleFactor = 0.25;
				else if (stageWidth < 1000) _textureScaleFactor = 0.5;
				else _textureScaleFactor = 1;
			}

			return _textureScaleFactor;
		}

		public static function get isAndroid():Boolean {
			return !isWeb && !iOS;
		}

		public static function traceMe():String {
			return formatString('\n' +
					'-------------\n' +
					'fps: {0}\n' +
					'baseWidth: {1}\n' +
					'baseHeight: {2}\n' +
					'stageWidth: {3}\n' +
					'stageHeight: {4}\n' +
					'starlingRect: {5}\n' +
					'viewRect: {6}\n' +
					'iOs: {7}\n' +
					'isWeb: {8}\n' +
					'dev: {9}\n' +
					'workspaceScale: {10}\n' +
					'textureScaleFactor: {11}\n' +
					'-------------',
					fps, baseWidth, baseHeight, stageWidth, stageHeight, starlingRect, viewRect, iOS, isWeb, DEV,
						workspaceScale, textureScaleFactor);
		}

		public static function asObject():Object {
			return {
				fps: fps,
				baseWidth: baseWidth,
				baseHeight: baseHeight,
				stageWidth: stageWidth,
				stageHeight: stageHeight,
				starlingRect: starlingRect.toString(),
				viewRect: viewRect.toString(),
				iOs: iOS,
				isWeb: isWeb,
				dev: DEV,
				workspaceScale: workspaceScale,
				textureScaleFactor: textureScaleFactor
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function AppProperties() {
			super();
		}
	}
}
