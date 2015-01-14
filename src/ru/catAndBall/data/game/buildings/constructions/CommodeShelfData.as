package ru.catAndBall.data.game.buildings.constructions {
	import ru.catAndBall.data.dict.CommodeShelfDict;
	import ru.catAndBall.data.dict.tools.ToolDict;
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

		public function CommodeShelfData(proto:CommodeShelfDict) {
			super(proto);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get availableTools():Vector.<ToolDict> {
			return (proto as CommodeShelfDict).tools;
		}
	}
}
