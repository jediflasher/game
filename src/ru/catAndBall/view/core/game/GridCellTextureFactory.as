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
		MAP[GridCellType.BALL_BLUE] = AssetList.fields_balls_object_balls_screenFieldBalls_ballBlue;
		MAP[GridCellType.BALL_GREEN] = AssetList.fields_balls_object_balls_screenFieldBalls_ballGreen;
		MAP[GridCellType.BALL_PURPLE] = AssetList.fields_balls_object_balls_screenFieldBalls_ballPurple;
		MAP[GridCellType.BALL_RED] = AssetList.fields_balls_object_balls_screenFieldBalls_ballRed;
		MAP[GridCellType.SWEATER_BLUE] = AssetList.fields_balls_object_balls_screenFieldBalls_sweaterBlue;
		MAP[GridCellType.SWEATER_GREEN] = AssetList.fields_balls_object_balls_screenFieldBalls_sweaterGreen;
		MAP[GridCellType.SWEATER_PURPLE] = AssetList.fields_balls_object_balls_screenFieldBalls_sweaterPurple;
		MAP[GridCellType.SWEATER_RED] = AssetList.fields_balls_object_balls_screenFieldBalls_sweaterRed;
		MAP[GridCellType.TOY_BLUE] = AssetList.fields_balls_object_balls_screenFieldBalls_toyBlue;
		MAP[GridCellType.TOY_GREEN] = AssetList.fields_balls_object_balls_frog;
		MAP[GridCellType.TOY_PURPLE] = AssetList.fields_balls_object_balls_screenFieldBalls_toyPurple;
		MAP[GridCellType.TOY_RED] = AssetList.fields_balls_object_balls_screenFieldBalls_toyRed;
		MAP[GridCellType.GRANNY] = AssetList.fields_balls_object_balls_screenFieldBalls_granny;
		MAP[GridCellType.WOLF] = AssetList.fields_balls_object_balls_screenFieldBalls_wolf;
		MAP[GridCellType.SOCKS] = AssetList.fields_balls_object_balls_socks;
		MAP[GridCellType.BALL_GOLD] = AssetList.fields_balls_object_balls_screenFieldBalls_ballGold;
		MAP[GridCellType.BALL] = AssetList.fields_carpet_object_carpet_screenFieldCarpet_ball;
		MAP[GridCellType.COOKIE] = AssetList.fields_carpet_object_carpet_cookie;
		MAP[GridCellType.MOUSE] = AssetList.fields_carpet_object_carpet_mouse;
		MAP[GridCellType.MILK] = AssetList.fields_carpet_object_carpet_milk;
		MAP[GridCellType.PIGEON] = AssetList.fields_carpet_object_carpet_dove;
		MAP[GridCellType.CONSERVE] = AssetList.fields_carpet_object_carpet_screenFieldCarpet_canned;
		MAP[GridCellType.GOLD_FISH] = AssetList.fields_carpet_object_carpet_screenFieldCarpet_goldfish;
		MAP[GridCellType.WRAPPER] = AssetList.fields_carpet_object_carpet_wrapper;
		MAP[GridCellType.THREAD] = AssetList.fields_carpet_object_carpet_threads;
		MAP[GridCellType.DOG] = AssetList.fields_carpet_object_carpet_screenFieldCarpet_yorkshire;
		MAP[GridCellType.PARROT] = AssetList.fields_carpet_object_carpet_parrot;



		public static function getTextureByType(type:int):Texture {
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
