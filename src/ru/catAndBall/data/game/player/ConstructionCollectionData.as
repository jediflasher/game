package ru.catAndBall.data.game.player {
	import ru.catAndBall.data.BaseData;
	import ru.catAndBall.data.dict.CommodeShelfDict;
	import ru.catAndBall.data.dict.ConstructionDict;
	import ru.catAndBall.data.dict.Dictionaries;
	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.data.game.buildings.constructions.CommodeShelfData;

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

		public var catHouse:CatHouseData;

		public var commode1:CommodeShelfData;

		public var commode2:CommodeShelfData;

		public var commode3:CommodeShelfData;

		public const list:Vector.<ConstructionData> = new Vector.<ConstructionData>();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function init():void {
			var constructions:Vector.<ConstructionDict> = Dictionaries.constructions.list;
			for each (var c:ConstructionDict in constructions) {
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
				result[construction.proto.id] = construction.serialize();
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
			var dict:ConstructionDict = Dictionaries.constructions.getConstructionById(id);
			var result:ConstructionData;
			switch (id) {
				case ConstructionData.CAT_HOUSE:
					result = catHouse = new CatHouseData(dict);
					break;
				case ConstructionData.COMMODE_1:
					result = commode1 = new CommodeShelfData(dict as CommodeShelfDict);
					break;
				case ConstructionData.COMMODE_2:
					result = commode2 = new CommodeShelfData(dict as CommodeShelfDict);
					break;
				case ConstructionData.COMMODE_3:
					result = commode3 = new CommodeShelfData(dict as CommodeShelfDict);
					break;
			}

			_hash[result.proto.id] = result;
			list.push(result);

			return result;
		}
	}
}
