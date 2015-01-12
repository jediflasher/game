package ru.catAndBall.view.core.game.factory {
	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.view.core.game.Construction;
	import ru.catAndBall.view.screens.room.CatHouse;
	import ru.catAndBall.view.screens.room.CommodeShelf1;
	import ru.catAndBall.view.screens.room.CommodeShelf2;
	import ru.catAndBall.view.screens.room.CommodeShelf3;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                07.12.14 18:16
	 */
	public class ConstructionViewFactory {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function createConstruction(data:ConstructionData):Construction {
			var result:Construction;
			if (data is CatHouseData) {
				result = new CatHouse(data as CatHouseData);
			} else if (data.dict.id == ConstructionData.COMMODE_1) {
				result = new CommodeShelf1(data);
			} else if (data.dict.id == ConstructionData.COMMODE_2) {
				result = new CommodeShelf2(data);
			} else if (data.dict.id == ConstructionData.COMMODE_3) {
				result = new CommodeShelf3(data);
			} else {
				throw new Error('Unkown construction');
			}

			result.data = data;
			return result;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionViewFactory() {
			super();
		}
	}
}
