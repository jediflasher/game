//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.tools {

	import flash.events.EventDispatcher;

	import ru.catAndBall.data.dict.tools.ToolDict;

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

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseToolData(dict:ToolDict, resourceSet:ResourceSet) {
			super();
			this.dict = dict;
			this.resourceSet = resourceSet;
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		public function get availableCount():int {
			return resourceSet.get(dict.resourceType);
		}

		public var dict:ToolDict;

		public var resourceSet:ResourceSet;
	}
}
