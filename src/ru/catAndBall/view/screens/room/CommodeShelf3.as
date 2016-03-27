package ru.catAndBall.view.screens.room {
	
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.view.core.game.Construction;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                09.01.15 11:58
	 */
	public class CommodeShelf3 extends Construction {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CommodeShelf3(data:ConstructionData) {
			super(data);
			showIfNotAvailable = true;
		}
	}
}
