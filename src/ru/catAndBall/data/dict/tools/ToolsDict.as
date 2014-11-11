package ru.catAndBall.data.dict.tools {
	import ru.catAndBall.data.game.ResourceSet;

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

			var tool:ToolDict = new ToolDict(ResourceSet.TOOL_BOWL);
			tool.price.set(ResourceSet.RF_BALL, 2);
			tool.price.set(ResourceSet.RF_WRAPPER, 5);
			_hash[ResourceSet.TOOL_BOWL] = tool;

			tool = new ToolDict(ResourceSet.TOOL_BROOM);
			tool.price.set(ResourceSet.BF_SOCKS, 2);
			tool.price.set(ResourceSet.BF_BALLS, 3);
			_hash[ResourceSet.TOOL_BROOM] = tool;

			tool = new ToolDict(ResourceSet.TOOL_SPOKES);
			tool.price.set(ResourceSet.RF_BALL, 1);
			_hash[ResourceSet.TOOL_SPOKES] = tool;

			tool = new ToolDict(ResourceSet.TOOL_SPOOL);
			tool.price.set(ResourceSet.BF_BALLS, 5);
			tool.price.set(ResourceSet.RF_BALL, 1);
			_hash[ResourceSet.TOOL_SPOOL] = tool;

			tool = new ToolDict(ResourceSet.TOOL_TEA);
			tool.price.set(ResourceSet.RF_WRAPPER, 5);
			tool.price.set(ResourceSet.RF_COOKIE, 3);
			_hash[ResourceSet.TOOL_TEA] = tool;

			tool = new ToolDict(ResourceSet.TOOL_TOY_BOX);
			tool.price.set(ResourceSet.BF_SOCKS, 2);
			_hash[ResourceSet.TOOL_TOY_BOX] = tool;
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
	}
}
