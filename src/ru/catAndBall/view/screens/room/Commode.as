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

		private var _shelf1:CommodeShelf1;

		private var _shelf2:CommodeShelf2;

		private var _shelf3:CommodeShelf3;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function added(event:* = null):void {
			super.added(event);

			_shelf1 = new CommodeShelf1(_data1);
			_shelf1.x = 215;
			_shelf1.y = 49;
			addChild(_shelf1);

			_shelf2 = new CommodeShelf2(_data2);
			_shelf2.x = 215;
			_shelf2.y = 174;
			addChild(_shelf2);

			_shelf3 = new CommodeShelf3(_data3);
			_shelf3.x = 215;
			_shelf3.y = 317;
			addChild(_shelf3);
		}
	}
}
