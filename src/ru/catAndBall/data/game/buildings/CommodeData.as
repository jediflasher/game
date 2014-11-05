package ru.catAndBall.data.game.buildings {
	import ru.catAndBall.data.dict.BuildingDict;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.10.14 14:27
	 */
	public class CommodeData extends BuildingData {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CommodeData() {
			var dict:BuildingDict = new BuildingDict();
			super(dict);
		}
	}
}
