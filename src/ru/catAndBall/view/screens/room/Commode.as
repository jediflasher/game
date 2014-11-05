package ru.catAndBall.view.screens.room {
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.game.Building;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                26.10.14 18:31
	 */
	public class Commode extends Building {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Commode() {
			super(GameData.player.buildings.commode, AssetList.Room_chest);
		}
	}
}
