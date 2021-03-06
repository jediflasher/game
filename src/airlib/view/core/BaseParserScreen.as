package airlib.view.core {

	import feathers.controls.IScreen;

	import ru.flaswf.parsers.feathers.view.ParserFeathersMovieClip;
	import ru.flaswf.reader.descriptors.DisplayObjectDescriptor;

	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                30.06.15 9:05
	 */
	public class BaseParserScreen extends ParserFeathersMovieClip implements IScreen {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseParserScreen(screenType:String, source:DisplayObjectDescriptor) {
			super(source);
			screenID = screenType;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var _screenID:String;

		public function get screenID():String {
			return this._screenID;
		}

		public function set screenID(value:String):void {
			this._screenID = value;
		}

		protected var _owner:Object;

		public function get owner():Object {
			return this._owner;
		}

		public function set owner(value:Object):void {
			this._owner = value;
		}

		public function bindEvent(target:DisplayObject, eventName:String, dispatch:String, data:Object = null):void {
			target.addEventListener(eventName, function(event:Event):void {
				dispatchEventWith(dispatch, false, data);
			});
		}

		public function bindEventBubble(target:DisplayObject, eventName:String, dispatch:String, data:Object = null):void {
			target.addEventListener(eventName, function(event:Event):void {
				dispatchEventWith(dispatch, true, data);
			});
		}
	}
}
