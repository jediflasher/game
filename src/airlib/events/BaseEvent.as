package airlib.events {

	import flash.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                21.06.15 19:42
	 */
	public class BaseEvent extends Event {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);

			this.data = data;
		}

		public var data:Object;


		public override function clone():Event {
			return new BaseEvent(type, data, bubbles, cancelable);
		}
	}
}
