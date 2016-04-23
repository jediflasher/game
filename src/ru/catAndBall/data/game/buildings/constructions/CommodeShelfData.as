package ru.catAndBall.data.game.buildings.constructions {
	
	import ru.catAndBall.data.proto.CommodeShelfProto;
	import ru.catAndBall.data.proto.tools.ToolProto;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                14.01.15 22:16
	 */
	public class CommodeShelfData extends ConstructionData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CommodeShelfData(proto:CommodeShelfProto) {
			super(proto);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get tools():Vector.<ToolProto> {
			return (proto as CommodeShelfProto).tools;
		}
	}
}
