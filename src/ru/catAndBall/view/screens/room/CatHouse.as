package ru.catAndBall.view.screens.room {
	import feathers.core.FeathersControl;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.game.Construction;
	import ru.catAndBall.view.hint.BaseConstructionHint;

	import starling.display.DisplayObject;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                27.09.14 14:54
	 */
	public class CatHouse extends Construction {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
 
		public function CatHouse(data:CatHouseData, asIcon:Boolean = false) {
			super(data, AssetList.Room_catHouse1, asIcon);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _hint:BaseConstructionHint;

		public override function get hint():DisplayObject {
			if (!data.state) return null;

			if (!_hint) _hint = new BaseConstructionHint(data as CatHouseData);
			return _hint;
		}

		// 260 30

		public override function get hintX():int {
			return 260;
		}

		public override function get hintY():int {
			return 30;
		}
	}
}
