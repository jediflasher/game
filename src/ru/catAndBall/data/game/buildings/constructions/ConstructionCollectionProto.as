package ru.catAndBall.data.game.buildings.constructions {
	
	import ru.catAndBall.data.proto.CommodeShelfProto;
	import ru.catAndBall.data.proto.ConstructionProto;
	import ru.catAndBall.data.game.buildings.ConstructionData;
	import ru.catAndBall.data.proto.ConstructionId;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                07.12.14 22:48
	 */
	public class ConstructionCollectionProto {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ConstructionCollectionProto() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _hash:Object = {}; // id -> ConstructionDict

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public const list:Vector.<ConstructionProto> = new Vector.<ConstructionProto>();

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function getConstructionById(id:String):ConstructionProto {
			return _hash[id];
		}

		public function deserialize(input:Object):void {
			for each(var obj:Object in input) {
				var dict:ConstructionProto = getConstructionDict(obj);
				_hash[dict.id] = dict;
				list.push(dict);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function getConstructionDict(obj:Object):ConstructionProto {
			var id:String = obj.id;
			var result:ConstructionProto;

			switch (id) {
				case ConstructionId.SHELF1:
				case ConstructionId.SHELF2:
				case ConstructionId.SHELF3:
					result = new CommodeShelfProto();
					break;
				default:
					result = new ConstructionProto();
			}

			result.deserialize(obj);
			return result;
		}
	}
}
