//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.player {
	
	import ru.catAndBall.data.BaseData;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.data.proto.ConstructionId;
	import ru.catAndBall.data.proto.Prototypes;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.view.core.game.Construction;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                19.07.14 13:40
	 */
	public class Player extends BaseData {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------


		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function Player() {
			super();
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		public const ballsField:GridData = new GridData(Prototypes.ballsFieldSettings);

		public const rugField:GridData = new GridData(Prototypes.rugFieldSettings);

		public const windowField:GridData = new GridData(Prototypes.windowFieldSettings);

		public const resources:ResourceSet = new ResourceSet();

		public const constructions:ConstructionCollectionData = new ConstructionCollectionData();

		public var name:String = 'Player';

		public function get level():int {
			return getLevelByExp(experience);
		}

		public function get nextLevelExp():Number {
			return getExpByLevel(level + 1);
		}

		public function get currrentLevelExp():Number {
			return getExpByLevel(level);
		}

		public function get catHouseLevel():int {
			var catHouse:ConstructionData = constructions.getConstructionById(ConstructionId.CATHOUSE);
			return catHouse ? catHouse.level : 0;
		}

		public function get money():int {
			return resources.get(ResourceSet.MONEY);
		}

		public function set money(value:int):void {
			resources.set(ResourceSet.MONEY, value);
		}

		public function get experience():Number {
			return resources.get(ResourceSet.EXPERIENCE);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function init():void {
			constructions.init();
		}

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			if ('constructions' in value) {
				constructions.deserialize(value.constructions);
			}

			if ('resources' in value) {
				resources.deserialize(value.resources);
			}

			if ('name' in value) {
				name = value.name;
			}
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			result['constructions'] = constructions.serialize();
			result['resources'] = resources.serialize();
			result['name'] = name;
			return result;
		}

		private function getLevelByExp(exp:Number):int {
			var m:Number = Prototypes.playerSettings.levelMultiplier;
			var m2:Number = m * 2;
			return int((m + Math.sqrt(m * m + 4 * m * exp)) / m2);
		}

		private function getExpByLevel(level:int):Number {
			if (level <= 1) return 0;
			return Prototypes.playerSettings.levelMultiplier * level * (level - 1);
		}
	}
}
