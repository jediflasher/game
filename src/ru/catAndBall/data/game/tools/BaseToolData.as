//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.tools {

	import flash.events.EventDispatcher;

	import ru.catAndBall.data.game.ResourceSet;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                10.08.14 14:01
	 */
	public class BaseToolData extends EventDispatcher {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_COUNT_CHANGE:String = 'eventCountChange';

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseToolData(resourceType:String, resourceSet:ResourceSet, name:String = null, description:String = null) {
			super();
			this.resourceSet = resourceSet;
			this.resourceType = resourceType;
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		public function get availableCount():int {
			return resourceSet.get(resourceType);
		}

		public var resourceSet:ResourceSet;

		public var resourceType:String;

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
