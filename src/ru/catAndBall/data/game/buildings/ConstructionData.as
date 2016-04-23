package ru.catAndBall.data.game.buildings {
	
	import com.greensock.TweenNano;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	import ru.catAndBall.data.BaseData;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.proto.ConstructionProto;
	import ru.catAndBall.data.proto.ConstructionStateProto;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.event.data.ConstructionDataEvent;
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

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionData(proto:ConstructionProto) {
			_proto = proto;
			if (!_proto) {
				trace();
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get id():String {
			return _proto.id;
		}

		private var _proto:ConstructionProto;

		public function get proto():ConstructionProto {
			return _proto;
		}

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
		public function get visible():Boolean {
			if (_proto.alwaysShow) return true;

			var catHouseLevel:int = GameData.player.catHouseLevel;
			return _proto.states[0].catHouseLevel <= catHouseLevel;
		}

		public function get state():ConstructionStateProto {
			if (level < 1) return null;
			return _proto.states[level - 1];
		}

		public function get nextState():ConstructionStateProto {
			var u:Vector.<ConstructionStateProto> = _proto.states;
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
			var s:ConstructionStateProto = state;
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

			var s:ConstructionStateProto = state;
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

		private var _customConnectCounts:Object;

		public function get customConnectCounts():Object {
			if (!this._customConnectCounts) {
				this._customConnectCounts = {};

				for (var i:int = 0; i < level; i++) {
					var state:ConstructionStateProto = _proto.states[i];
					if (!state.customConnectCounts) continue;

					for (var elementName:String in state.customConnectCounts) {
						this._customConnectCounts[elementName] = state.customConnectCounts[elementName];
					}
				}
			}

			return this._customConnectCounts;
		}

		private var _freeToCollect:Vector.<String>;

		public function get freeToCollect():Vector.<String> {
			if (!this._freeToCollect) {
				this._freeToCollect = new Vector.<String>();

				for (var i:int = 0; i < level; i++) {
					var state:ConstructionStateProto = _proto.states[i];
					if (!state.freeToCollect) continue;

					for each (var elementName:String in state.freeToCollect) {
						this._freeToCollect.push(elementName);
					}
				}
			}

			return this._freeToCollect;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function startBuilding():void {
			var startTimeSeconds:Number = TimeUtil.now;
			var upgrade:ConstructionStateProto = nextState;

			if (!upgrade) throw new IllegalOperationError('No upgrade found');
			if (!upgrade.buildTime) {
				_startBuildingTime = 0;
				return;
			}

			if (hasEventListener(ConstructionDataEvent.BUILDING_START)) dispatchEvent(new ConstructionDataEvent(ConstructionDataEvent.BUILDING_START));

			_startBuildingTime = startTimeSeconds;
			updateTimers();
		}

		/**
		 * @return true, если есть возможность ускорить апгрейд сейчас
		 */
		public function hasSpeedUp():Boolean {
			var tl:Number = constructTimeLeft;
			if (!tl) return false;

			var nu:ConstructionStateProto = nextState;
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
			if (hasEventListener(ConstructionDataEvent.BONUS_COLLECTED)) dispatchEvent(new ConstructionDataEvent(ConstructionDataEvent.BONUS_COLLECTED));

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

			// to update counts including new built state
			this._customConnectCounts = null;
			if (super.hasEventListener(ConstructionDataEvent.BUILDING_COMPLETE)) dispatchEvent(new ConstructionDataEvent(ConstructionDataEvent.BUILDING_COMPLETE));
		}

		private function bonusTimeComplete():void {
			updateTimers();
			if (super.hasEventListener(ConstructionDataEvent.BONUS_READY)) dispatchEvent(new ConstructionDataEvent(ConstructionDataEvent.BONUS_READY));
		}
	}
}
