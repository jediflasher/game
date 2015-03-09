package ru.catAndBall.data.game.buildings {
	import com.greensock.TweenNano;

	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import ru.catAndBall.data.BaseData;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.dict.ConstructionDict;
	import ru.catAndBall.data.dict.ConstructionState;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.utils.TimeUtil;
	import ru.catAndBall.view.core.utils.L;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                10.09.14 18:29
	 */
	public class ConstructionData extends BaseData {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_BUILDING_START:String = 'eventBuildingStart';

		public static const EVENT_BUILDING_COMPLETE:String = 'eventBuildingComplete';

		public static const EVENT_BONUS_TIME_COMPLETE:String = 'eventBonusTimeComplete';

		public static const EVENT_BONUS_COLLECTED:String = 'eventBonusCollected';

		public static const CAT_HOUSE:String = 'catHouse';

		public static const COMMODE_1:String = 'commode1';

		public static const COMMODE_2:String = 'commode2';

		public static const COMMODE_3:String = 'commode3';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionData(proto:ConstructionDict) {
			_proto = proto;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _level:int = 0;

		public function get level():int {
			return _level;
		}

		/**
		 * Timestamp start of building upgrade
		 */
		private var _startBuildingTime:Number = 0;

		public function get startBuildingTime():Number {
			return _startBuildingTime;
		}

		/**
		 * Timestamp last collecting bonus time
		 */
		private var _lastBonusTime:Number = 0;

		public function get lastBonusTime():Number {
			return _lastBonusTime;
		}

		private var _proto:ConstructionDict;

		public function get proto():ConstructionDict {
			return _proto;
		}

		public function get visible():Boolean {
			var catHouseLevel:int = GameData.player.catHouseLevel;
			return _proto.states[0].catHouseLevel <= catHouseLevel;
		}

		public function get state():ConstructionState {
			if (level < 1) return null;
			return _proto.states[level - 1];
		}

		public function get nextState():ConstructionState {
			var u:Vector.<ConstructionState> = _proto.states;
			if (u.length <= level) return null;
			return u[level];
		}

		public function get constructTimeLeft():Number {
			if (!_startBuildingTime) return 0;
			if (!nextState) return 0;

			var endTime:Number = _startBuildingTime + nextState.buildTime;
			var result:Number = endTime - TimeUtil.now;
			if (result < 0) return 0;
			return result;
		}

		public function get bonusTimeLeft():Number {
			var s:ConstructionState = state;
			if (!s) return 0;
			if (!s.bonusPeriod) return 0;
			if (!lastBonusTime) return 0;

			var endTime:Number = lastBonusTime + s.bonusPeriod;
			var result:Number = endTime - TimeUtil.now;
			if (result < 0) return 0;
			return result;
		}

		public function get bonus():ResourceSet {
			if (!lastBonusTime) return null;

			var s:ConstructionState = state;
			if (!s) return null;
			if (s.bonus.isEmpty) return null;

			return s.bonus;
		}

		public function get canCollectBonus():Boolean {
			return bonus && bonusTimeLeft <= 0;
		}

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			if ('level' in value) this._level = value.level;
			if ('startBuildingTime' in value) this._startBuildingTime = value.startBuildingTime;
			if ('lastBonusTime' in value) this._lastBonusTime = value.lastBonusTime;

			updateTimers();
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			result['level'] = _level;
			result['startBuildingTime'] = _startBuildingTime;
			result['lastBonusTime'] = _lastBonusTime;

			return result;
		}

		private var _name:String;

		public function get name():String {
			if (!_name) _name = L.get('construction.' + _proto.id + '.name');
			return _name;
		}

		private var _description:String;

		public function get description():String {
			if (!_description) _description = L.get('construction.' + _proto.id + '.desc');
			return _description;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function startBuilding():void {
			var startTimeSeconds:Number = TimeUtil.now;
			var upgrade:ConstructionState = nextState;

			if (!upgrade) throw new IllegalOperationError('No upgrade found');
			if (!upgrade.buildTime) {
				_startBuildingTime = 0;
				return;
			}

			if (hasEventListener(EVENT_BUILDING_START)) dispatchEvent(new Event(EVENT_BUILDING_START));

			_startBuildingTime = startTimeSeconds;
			updateTimers();
		}

		/**
		 * @return true, если есть возможность ускорить апгрейд сейчас
		 */
		public function hasSpeedUp():Boolean {
			var tl:Number = constructTimeLeft;
			if (!tl) return false;

			var nu:ConstructionState = nextState;
			if (!nu) return false;

			return !nu.speedUpPrice.isEmpty;
		}

		public function speedUp():void {
			var res:ResourceSet = GameData.player.resources;
			if (!res.hasEnough(nextState.speedUpPrice)) throw new IllegalOperationError('Not enough resources');

			res.substract(nextState.speedUpPrice);
			buildingComplete();
		}

		public function collectBonus():ResourceSet {
			if (bonusTimeLeft > 0) throw new IllegalOperationError('Bonus not ready');

			_lastBonusTime = TimeUtil.now;
			updateTimers();
			if (hasEventListener(EVENT_BONUS_COLLECTED)) dispatchEvent(new Event(EVENT_BONUS_COLLECTED));

			return bonus;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function updateTimers():void {
			if (!visible) return;

			if (_startBuildingTime > 0) {
				if (constructTimeLeft > 0) {
					TweenNano.delayedCall(constructTimeLeft, buildingComplete);
				} else {
					buildingComplete();
				}
			} else if (bonusTimeLeft > 0) {
				TweenNano.delayedCall(bonusTimeLeft, bonusTimeComplete);
			} else {
				TweenNano.killTweensOf(buildingComplete);
				TweenNano.killTweensOf(bonusTimeComplete);
			}
		}

		private function buildingComplete():void {
			_level += 1;
			_startBuildingTime = 0;
			_lastBonusTime = TimeUtil.now;
			updateTimers();
			if (super.hasEventListener(EVENT_BUILDING_COMPLETE)) dispatchEvent(new Event(EVENT_BUILDING_COMPLETE));
		}

		private function bonusTimeComplete():void {
			updateTimers();
			if (super.hasEventListener(EVENT_BONUS_TIME_COMPLETE)) dispatchEvent(new Event(EVENT_BONUS_TIME_COMPLETE));
		}
	}
}
