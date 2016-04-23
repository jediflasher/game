package ru.catAndBall.data.proto.tools {
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.11.14 22:10
	 */
	public class ToolProtoCollection {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ToolProtoCollection() {
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

		public function getToolByResourceType(resourceType:String):ToolProto {
			return _hash[resourceType];
		}

		public function deserialize(input:Object):void {
			for (var toolResource:String in input) {
				var toolObj:Object = input[toolResource];
				var tool:ToolProto = new ToolProto(toolResource);
				tool.deserialize(toolObj);
				_hash[tool.resourceType] = tool;
			}
		}
	}
}
