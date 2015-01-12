//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.player {

	import ru.catAndBall.data.BaseData;
	import ru.catAndBall.data.dict.Dictionaries;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.field.GridData;

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

		public const ballsField:GridData = new GridData(Dictionaries.ballsFieldSettings);

		public const rugField:GridData = new GridData(Dictionaries.rugFieldSettings);

		public const windowField:GridData = new GridData(Dictionaries.windowFieldSettings);

		public const resources:ResourceSet = new ResourceSet();

		public const constructions:ConstructionCollectionData = new ConstructionCollectionData();


		public function get level():int {
			return resources.get(ResourceSet.EXPERIENCE) / 10;
		}

		// helpers
		public function get catHouseLevel():int {
			return constructions.catHouse.level;
		}

		public function get money():int {
			return resources.get(ResourceSet.MONEY);
		}

		public function set money(value:int):void {
			resources.set(ResourceSet.MONEY, value);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			if ('constructions' in value) {
				constructions.deserialize(value.constructions);
			}

			if ('resources' in value) {
				resources.deserialize(value.resources);
			}
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			result['constructions'] = constructions.serialize();
			result['resources'] = resources.serialize();
			return result;
		}
	}
}
