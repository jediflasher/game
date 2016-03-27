//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game {
	
	import ru.catAndBall.data.game.field.GridCellType;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	
	import starling.textures.Texture;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 12:49
	 */
	public class GridCellTextureFactory {

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		private static const MAP:Object = {};
		MAP[GridCellType.BALL_BLUE] = AssetList.fields_balls_object_balls_ballBlue;
		MAP[GridCellType.BALL_GREEN] = AssetList.fields_balls_object_balls_ballGreen;
		MAP[GridCellType.BALL_PURPLE] = AssetList.fields_balls_object_balls_ballPurple;
		MAP[GridCellType.BALL_RED] = AssetList.fields_balls_object_balls_ballRed;
		MAP[GridCellType.SWEATER_BLUE] = AssetList.fields_balls_object_balls_sweaterBlue;
		MAP[GridCellType.SWEATER_GREEN] = AssetList.fields_balls_object_balls_sweaterGreen;
		MAP[GridCellType.SWEATER_PURPLE] = AssetList.fields_balls_object_balls_sweaterPurple;
		MAP[GridCellType.SWEATER_RED] = AssetList.fields_balls_object_balls_sweaterRed;
		MAP[GridCellType.TOY_BLUE] = AssetList.fields_balls_object_balls_toyBlue;
		MAP[GridCellType.TOY_GREEN] = AssetList.fields_balls_object_balls_toyGreen;
		MAP[GridCellType.TOY_PURPLE] = AssetList.fields_balls_object_balls_toyPurple;
		MAP[GridCellType.TOY_RED] = AssetList.fields_balls_object_balls_toyRed;
		MAP[GridCellType.GRANNY] = AssetList.fields_balls_object_balls_granny;
		MAP[GridCellType.WOLF] = AssetList.fields_balls_object_balls_wolf;
		MAP[GridCellType.SOCKS] = AssetList.fields_balls_object_balls_socks;
		MAP[GridCellType.BALL_GOLD] = AssetList.fields_balls_object_balls_ballGold;
		MAP[GridCellType.BALL] = AssetList.fields_carpet_object_carpet_glob;
		MAP[GridCellType.COOKIE] = AssetList.fields_carpet_object_carpet_cookie;
		MAP[GridCellType.MOUSE] = AssetList.fields_carpet_object_carpet_mouse;
		MAP[GridCellType.MILK] = AssetList.fields_carpet_object_carpet_milk;
		MAP[GridCellType.PIGEON] = AssetList.fields_carpet_object_carpet_dove;
		MAP[GridCellType.CONSERVE] = AssetList.fields_carpet_object_carpet_canned;
		MAP[GridCellType.GOLD_FISH] = AssetList.fields_carpet_object_carpet_goldfish;
		MAP[GridCellType.GRAIN] = AssetList.fields_carpet_object_carpet_grain;
		MAP[GridCellType.THREAD] = AssetList.fields_carpet_object_carpet_threads;
		MAP[GridCellType.DOG] = AssetList.fields_carpet_object_carpet_yorkshire;
		MAP[GridCellType.PARROT] = AssetList.fields_carpet_object_carpet_parrot;



		public static function getTextureByType(type:String):Texture {
			return Assets.getTexture(MAP[type]);
		}

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GridCellTextureFactory() {
			super();
		}
	}
}
