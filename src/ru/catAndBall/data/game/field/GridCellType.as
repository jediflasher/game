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

		public static const BALL_RED:int = 1;

		public static const BALL_GREEN:int = 2;

		public static const BALL_BLUE:int = 3;

		public static const BALL_PURPLE:int = 4;

		public static const TOY_RED:int = 5;

		public static const TOY_GREEN:int = 6;

		public static const TOY_BLUE:int = 7;

		public static const TOY_PURPLE:int = 8;

		public static const SWEATER_RED:int = 9;

		public static const SWEATER_GREEN:int = 10;

		public static const SWEATER_BLUE:int = 11;

		public static const SWEATER_PURPLE:int = 12;

		public static const WOLF:int = 13;

		public static const GRANNY:int = 14;

		public static const SOCKS:int = 15;

		public static const BALL_GOLD:int = 16;

		// rug

		public static const BALL:int = 21;

		public static const COOKIE:int = 22;

		public static const MOUSE:int = 23;

		public static const MILK:int = 24;

		public static const PIGEON:int = 25;

		public static const CONSERVE:int = 26;

		public static const GOLD_FISH:int = 27;

		public static const WRAPPER:int = 28;

		public static const THREAD:int = 29;

		public static const DOG:int = 30;

		public static const PARROT:int = 31;

		// window field


		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function getResourceType(gridCellType:int):String {
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
				case GridCellType.WRAPPER:
					return ResourceSet.RF_WRAPPER;
				default:
					return null;
			}
		}

		public static function hasResourceType(gridCellType):Boolean {
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
