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
	public class ConstructionState {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionState() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var index:int = 0;

		public var lockedToLevel:int;

		public var catHouseLevel:int;

		public var buildTime:int; // in seconds

		public const price:ResourceSet = new ResourceSet();

		public const speedUpPrice:ResourceSet = new ResourceSet();

		public var bonusPeriod:Number = 0; // in seconds

		public const bonus:ResourceSet = new ResourceSet();

		public var customConnectCounts:Object;

		public var customCollectTurnPrice:Object;

		public var freeToCollect:Array;

		public function get hasEnoughSources():Boolean {
			return GameData.player.resources.hasEnough(price);
		}

		public function deserialize(input:Object):void {
			if ('lockedToLevel' in input) {
				lockedToLevel = input.lockedToLevel;
			}

			if ('catHouseLevel' in input) {
				catHouseLevel = input.catHouseLevel;
			}

			if ('buildTime' in input) {
				buildTime = input.buildTime;
			}

			if ('price' in input) {
				price.deserialize(input.price);
			}

			if ('speedUpPrice' in input) {
				speedUpPrice.deserialize(input.speedUpPrice);
			}

			if ('bonusPeriod' in input) {
				bonusPeriod = input.bonusPeriod;
			}

			if ('bonus' in input) {
				bonus.deserialize(input.bonus);
			}

			if ('customConnectCounts' in input) {
				customConnectCounts = input.customConnectCounts;
			}

			if ('customCollectTurnPrice' in input) {
				customCollectTurnPrice = input.customCollectTurnPrice;
			}

			if ('freeToCollect' in input) {
				freeToCollect = input.freeToCollect;
			}
		}
	}
}
