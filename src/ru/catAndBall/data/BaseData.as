package ru.catAndBall.data {
	import flash.events.EventDispatcher;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.10.14 11:33
	 */
	public class BaseData extends EventDispatcher {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseData() {
			super();
		}

		public function serialize():Object {
			return {};
		}

		public function deserialize(value:Object):void {

		}
	}
}
