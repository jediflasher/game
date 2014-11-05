package ru.catAndBall.data.dict {
	import ru.catAndBall.data.game.ResourceSet;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:06
	 */
	public class BuildingDict {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BuildingDict() {
			super();
		}

		public const states:Vector.<BuildingState> = new Vector.<BuildingState>();

		public var catHouseLevel:int;

		public function get maxLevel():int {
			return states.length;
		}
	}
}
