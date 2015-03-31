package ru.catAndBall.data.dict {
	import ru.catAndBall.data.dict.tools.ToolDict;
	import ru.catAndBall.view.core.utils.ArrayUtils;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                14.01.15 22:19
	 */
	public class CommodeShelfDict extends ConstructionDict {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CommodeShelfDict() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _tools:Vector.<ToolDict>;

		public function get tools():Vector.<ToolDict> {
			if (!_tools) {
				_tools = new Vector.<ToolDict>();
				for each (var state:CommodeShelfState in states) {
					for each (var tool:ToolDict in state.tools) {
						_tools.push(tool);
					}
				}
			}
			return _tools;
		}


		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function deserialize(input:Object):void {
			super.deserialize(input);
		}

		protected override function createState():ConstructionState {
			return new CommodeShelfState();
		}
	}
}
