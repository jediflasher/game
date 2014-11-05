//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.screens {

	import flash.events.EventDispatcher;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                03.07.14 12:29
	 */
	public class BaseScreenData extends EventDispatcher {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseScreenData(screenType:String) {
			super();
			this._type = screenType;
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		/**
		 * @private
		 */
		private var _type:String;

		public function get type():String {
			return this._type;
		}
	}
}
