package ru.catAndBall.view.screens.room {
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.BaseSprite;

	import starling.display.Image;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                26.10.14 18:31
	 */
	public class Commode extends BaseSprite {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Commode(data1:ConstructionData, data2:ConstructionData, data3:ConstructionData) {
			super();

			this._data1 = data1;
			this._data2 = data2;
			this._data3 = data3;

			_view = Assets.getImage(AssetList.Room_chest);
			addChild(_view);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _view:Image;

		private var _data1:ConstructionData;

		private var _data2:ConstructionData;

		private var _data3:ConstructionData;
	}
}
