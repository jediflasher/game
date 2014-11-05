package ru.catAndBall.view.screens.room {
	import feathers.core.FeathersControl;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.game.Building;

	import starling.display.DisplayObject;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.09.14 14:54
	 */
	public class CatHouse extends Building {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
 
		public function CatHouse() {
			super(GameData.player.buildings.catHouse, AssetList.Room_cat_house_lvl1.replace('lvl1', 'lvl'));
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _hint:CatHouseHint;

		public override function get hint():FeathersControl {
			if (!data.state) return null;

			if (!_hint) _hint = new CatHouseHint(data as CatHouseData);
			return _hint;
		}
	}
}
