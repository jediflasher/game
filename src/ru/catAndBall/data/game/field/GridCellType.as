//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.field {
	
	import ru.catAndBall.data.game.ResourceSet;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                23.06.14 23:09
	 */
	public class GridCellType {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		// balls

		public static const BALL_RED:String = 'bf_ballRed';

		public static const BALL_GREEN:String = 'bf_ballGreen';

		public static const BALL_BLUE:String = 'bf_ballBlue';

		public static const BALL_PURPLE:String = 'bf_ballPurple';

		public static const TOY_RED:String = "bf_toyRed";

		public static const TOY_GREEN:String = "bf_toyGreen";

		public static const TOY_BLUE:String = "bf_toyBlue";

		public static const TOY_PURPLE:String = "bf_toyPurple";

		public static const SWEATER_RED:String = "bf_sweaterRed";

		public static const SWEATER_GREEN:String = "bf_sweaterGreen";

		public static const SWEATER_BLUE:String = "bf_sweaterBlue";

		public static const SWEATER_PURPLE:String = "bf_sweaterPurple";

		public static const WOLF:String = "bf_wolf";

		public static const GRANNY:String = "bf_granny";

		public static const SOCKS:String = "bf_socks";

		public static const BALL_GOLD:String = "bf_ballGold";

		// rug

		public static const BALL:String = "rf_ball";

		public static const COOKIE:String = "rf_cookie";

		public static const MOUSE:String = "rf_mouse";

		public static const MILK:String = "rf_milk";

		public static const PIGEON:String = "rf_pigeon";

		public static const CONSERVE:String = "rf_conserve";

		public static const GOLD_FISH:String = "rf_goldFish";

		public static const GRAIN:String = "rf_grain";

		public static const THREAD:String = "rf_thread";

		public static const DOG:String = "rf_dog";

		public static const PARROT:String = "rf_parrot";

		public static const WRAPPER:String = 'rf_wrapper';

		// window field


		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function getResourceType(gridCellType:String):String {
			switch (gridCellType) {
				case GridCellType.BALL_BLUE:
				case GridCellType.BALL_GREEN:
				case GridCellType.BALL_RED:
				case GridCellType.BALL_PURPLE:
					return ResourceSet.BF_BALLS;
					break;
				case GridCellType.SWEATER_BLUE:
				case GridCellType.SWEATER_GREEN:
				case GridCellType.SWEATER_RED:
				case GridCellType.SWEATER_PURPLE:
					return ResourceSet.BF_SWEATERS;
					break;
				case GridCellType.TOY_BLUE:
				case GridCellType.TOY_GREEN:
				case GridCellType.TOY_RED:
				case GridCellType.TOY_PURPLE:
					return ResourceSet.BF_TOYS;
					break;
				case GridCellType.SOCKS:
					return ResourceSet.BF_SOCKS;
					break;
				case GridCellType.CONSERVE:
					return ResourceSet.RF_CONSERVE;
					break;
				case GridCellType.COOKIE:
					return ResourceSet.RF_COOKIE;
					break;
				case GridCellType.BALL:
					return ResourceSet.RF_BALL;
					break;
				case GridCellType.MILK:
					return ResourceSet.RF_MILK;
					break;
				case GridCellType.MOUSE:
					return ResourceSet.RF_MOUSE;
					break;
				case GridCellType.PIGEON:
					return ResourceSet.RF_PIGEON;
					break;
				case GridCellType.THREAD:
					return ResourceSet.RF_THREAD;
					break;
				case GridCellType.GRAIN:
					return ResourceSet.RF_GRAIN;
				default:
					return null;
			}
		}

		public static function hasResourceType(gridCellType:String):Boolean {
			return getResourceType(gridCellType) != null;
		}

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function GridCellType() {
			super();
		}
	}
}
