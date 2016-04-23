//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.event.data {
	
	import flash.events.Event;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                23.06.14 23:27
	 */
	public class DataEvent extends Event {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function DataEvent(type:String, data:Object = null) {
			super(type, false, false);
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
			return new (Object(this).constructor as Class)(type, data);	
		}
	}
}
