package airlib {

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;

	import ru.airlib.controller.BaseAppController;
	import ru.airlib.util.Assets;
	import ru.airlib.util.log.Log;
	import ru.airlib.view.BaseAppView;

	import starling.core.Starling;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.SystemUtil;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                15.06.15 10:27
	 */
	public class BaseApp extends Sprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseApp() {
			super();

			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		protected var _starling:Starling;

		protected var _assetManager:AssetManager;

		protected var _controller:BaseAppController;

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected function init(event:Event = null):void {
			AppProperties.fps = 60;
			AppProperties.baseWidth = 1536;
			AppProperties.baseHeight = 2048;
			AppProperties.iOS = Capabilities.manufacturer.indexOf("iOS") > -1;
			AppProperties.isWeb = !SystemUtil.isAIR;

			var clName:String = 'flash.desktop.NativeApplication';
			if (ApplicationDomain.currentDomain.hasDefinition(clName)) {
				var na:Class = ApplicationDomain.currentDomain.getDefinition(clName) as Class;
				if (na) {
					na['nativeApplication']['executeInBackground'] = false;
				}
			}
			loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, handler_uncaughtError);

			var url:String = stage.loaderInfo['url'] || '.';
			AppProperties.DEV = url ? url.search(/(localhost|127\.0\.0\.1|file:)/) >= 0 : false;

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = AppProperties.fps;

			Starling.multitouchEnabled = false;
			Starling.handleLostContext = !AppProperties.iOS;

			var stageWidth:Number = AppProperties.isWeb ? stage.stageWidth : stage.fullScreenWidth;
			var stageHeight:Number = AppProperties.isWeb ? stage.stageHeight : stage.fullScreenHeight;

			AppProperties.stageWidth = stageWidth;
			AppProperties.stageHeight = stageHeight;

			var r:Rectangle = RectangleUtil.fit(
					new Rectangle(0, 0, AppProperties.baseWidth, AppProperties.baseHeight),
					new Rectangle(0, 0, stageWidth, stageHeight),
					ScaleMode.NO_BORDER);

			AppProperties.starlingRect = r;
			AppProperties.viewRect.x = -r.x;
			AppProperties.viewRect.y = -r.y;
			AppProperties.viewRect.setTo(-r.x, -r.y, stageWidth, stageHeight);

			var factor:Number = 0;
			if (AppProperties.starlingRect.x < 0) {
				factor = AppProperties.starlingRect.width / (AppProperties.baseWidth * AppProperties.textureScaleFactor);
			} else {
				factor = AppProperties.starlingRect.height / (AppProperties.baseHeight * AppProperties.textureScaleFactor);
			}

			_starling = new Starling(getAppViewClass(), stage, AppProperties.starlingRect, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE_EXTENDED);
			_starling.stage.stageWidth = AppProperties.starlingRect.width / factor;
			_starling.stage.stageHeight = AppProperties.starlingRect.height / factor;
			_starling.simulateMultitouch = false;
			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.addEventListener('rootCreated', rootCreated);
//			_starling.showStatsAt(HAlign.CENTER, VAlign.TOP, AppProperties.workspaceScale);
			_starling.showStats = false;
			_starling.supportHighResolutions = true;

			AppProperties.workspaceScale = AppProperties.textureScaleFactor;//AppProperties.starlingRect.width / AppProperties.baseWidth;

			var bg:DisplayObject = getBackground();
			bg.x = AppProperties.starlingRect.x;
			bg.y = AppProperties.starlingRect.y;
			bg.width = AppProperties.starlingRect.width;
			bg.height = AppProperties.starlingRect.height;
			addChild(bg);
		}

		protected function getAppViewClass():Class {
			throw new Error('Must be overwritten');
		}

		protected function getAppControllerClass():Class {
			throw new Error('Must be overwritten');
		}

		protected function getBackground():DisplayObject {
			throw new Error('Must be overwritten');
		}

		protected function rootCreated(event:*, app:BaseAppView):void {
			_starling.removeEventListener('rootCreated', rootCreated);
			_starling.start();

			var controllerClass:Class = getAppControllerClass();
			_controller = new (controllerClass)(app);

			Assets.initComplete();
			AppProperties.traceMe();
		}

		protected function progress(progress:Number):void {
			_controller.setProgress(progress);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_uncaughtError(event:UncaughtErrorEvent):void {
			Log.captureError(event.error);
		}
	}
}
