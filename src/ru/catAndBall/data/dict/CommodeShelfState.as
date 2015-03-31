package ru.catAndBall.data.dict {
	import ru.catAndBall.data.dict.tools.ToolDict;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                18.03.15 9:39
	 */
	public class CommodeShelfState extends ConstructionState {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CommodeShelfState() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const tools:Vector.<ToolDict> = new Vector.<ToolDict>();

		public override function deserialize(input:Object):void {
			super.deserialize(input);

			if ('tools' in input) {
				for each (var id:String in input.tools) {
					var tool:ToolDict = Dictionaries.tools.getToolByResourceType(id);
					tools.push(tool);
				}
			}
		}
	}
}
