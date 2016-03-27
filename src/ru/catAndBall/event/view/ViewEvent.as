//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.event.view {
	
	import flash.events.Event;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                23.06.14 23:27
	 */
	public class ViewEvent extends Event {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ViewEvent(type:String, bubbles:Boolean = false, data:Object = null) {
			super(type, bubbles, false);
			this.data = data;
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		public var data:Object = null;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public override function clone():Event {
			return new ViewEvent(type, bubbles, data);
		}
	}
}
