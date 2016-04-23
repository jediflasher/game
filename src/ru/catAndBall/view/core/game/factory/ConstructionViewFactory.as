package ru.catAndBall.view.core.game.factory {
	
	import flash.display.BitmapData;
	
	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.Construction;
	import ru.catAndBall.view.screens.room.CatHouse;
	import ru.catAndBall.view.screens.room.CommodeShelf1;
	import ru.catAndBall.view.screens.room.CommodeShelf;
	import ru.catAndBall.view.screens.room.CommodeShelf3;
	
	import starling.textures.Texture;
	
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
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static var FAKE_TEXTURE:Texture = Texture.fromBitmapData(new BitmapData(100, 100, false, Math.random() * 0xFFFFFF));

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function getIcon(data:ConstructionData):Texture {
			var stateIndex:int = data.state ? data.state.index : 0;
			var result:Texture = Assets.getTexture(data.id + '_' + int(stateIndex + 1));
			if (!result) result = Assets.getTexture(data.id) || FAKE_TEXTURE;
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
