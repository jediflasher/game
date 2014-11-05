package ru.catAndBall.data.dict {
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 13:36
	 */
	public class BuildingState {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BuildingState() {

		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var index:int = 0;

		public var lockedToLevel:int;

		public var buildTime:int; // in seconds

		public const price:ResourceSet = new ResourceSet();

		public const speedUpPrice:ResourceSet = new ResourceSet();

		public var bonusPeriod:Number = 0; // in seconds

		public const bonus:ResourceSet = new ResourceSet();

		public function get hasEnoughSources():Boolean {
			return GameData.player.resources.hasEnough(price);
		}
	}
}
