package ru.catAndBall.data.dict.tools {
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.11.14 22:10
	 */
	public class ToolsDict {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ToolsDict() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private const _hash:Object = {};

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function getToolByResourceType(resourceType:String):ToolDict {
			return _hash[resourceType];
		}

		public function deserialize(input:Object):void {
			for (var toolResource:String in input) {
				var toolObj:Object = input[toolResource];
				var tool:ToolDict = new ToolDict(toolResource);
				tool.deserialize(toolObj);
			}
		}
	}
}
