package ru.catAndBall.data.game.player {
	
	import ru.catAndBall.data.BaseData;
	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.data.game.buildings.constructions.CommodeShelfData;
	import ru.catAndBall.data.proto.ConstructionId;
	import ru.catAndBall.data.proto.ConstructionProto;
	import ru.catAndBall.data.proto.Prototypes;
	import ru.catAndBall.event.data.ConstructionDataEvent;
	import ru.catAndBall.view.screens.room.CatHouse;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                20.09.14 11:06
	 */
	public class ConstructionCollectionData extends BaseData {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const _MAP:Object = {};
		_MAP[ConstructionId.CATHOUSE] = CatHouseData;
		_MAP[ConstructionId.SHELF1] = CommodeShelfData;
		_MAP[ConstructionId.SHELF2] = CommodeShelfData;
		_MAP[ConstructionId.SHELF3] = CommodeShelfData;


		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionCollectionData() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private const _hash:Object = {};

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const list:Vector.<ConstructionData> = new Vector.<ConstructionData>();

		/**
		 * Строится ли хотя бы одно здание
		 */
		public function get inConstruction():Boolean {
			for each (var c:ConstructionData in list) {
				if (c.constructTimeLeft > 0) return true;
			}

			return false;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function init():void {
			var constructions:Vector.<ConstructionProto> = Prototypes.constructions.list;
			for each (var c:ConstructionProto in constructions) {
				createConstruction(c.id);
			}
		}

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			for each(var obj:Object in value) {
				var id:String = obj.id;
				var construction:ConstructionData = getConstructionById(id) || createConstruction(id);
				construction.deserialize(obj);
			}
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			for each (var construction:ConstructionData in list) {
				result[construction.id] = construction.serialize();
			}
			return result;
		}

		public function getConstructionById(id:String):ConstructionData {
			return _hash[id] as ConstructionData;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function createConstruction(id:String):ConstructionData {
			var proto:ConstructionProto = Prototypes.constructions.getConstructionById(id);
			var result:ConstructionData = new (_MAP[id] || ConstructionData)(proto);

			_hash[result.id] = result;
			list.push(result);

			result.addEventListener(ConstructionDataEvent.BUILDING_START, dispatchEvent);
			result.addEventListener(ConstructionDataEvent.BUILDING_COMPLETE, dispatchEvent);

			return result;
		}
	}
}
