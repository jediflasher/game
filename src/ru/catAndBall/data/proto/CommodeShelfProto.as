package ru.catAndBall.data.proto {
	
	import ru.catAndBall.data.proto.tools.ToolProto;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                14.01.15 22:19
	 */
	public class CommodeShelfProto extends ConstructionProto {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CommodeShelfProto() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _tools:Vector.<ToolProto>;

		public function get tools():Vector.<ToolProto> {
			if (!_tools) {
				_tools = new Vector.<ToolProto>();
				for each (var state:CommodeShelfStateProto in states) {
					for each (var tool:ToolProto in state.tools) {
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

		protected override function createState():ConstructionStateProto {
			return new CommodeShelfStateProto();
		}
	}
}
