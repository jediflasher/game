//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.data.game.player {

	import flash.events.EventDispatcher;

	import ru.catAndBall.data.BaseData;

	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.settings.BallsFieldSettings;
	import ru.catAndBall.data.game.settings.RugFieldSettings;

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

		public const ballsField:GridData = new GridData(new BallsFieldSettings());

		public const rugField:GridData = new GridData(new RugFieldSettings());

		public const windowField:GridData = new GridData(new GridFieldSettings());

		public const resources:ResourceSet = new ResourceSet();

		public const buildings:BuildingsData = new BuildingsData();

		public function get level():int {
			return resources.get(ResourceSet.EXPERIENCE) / 10;
		}

		// helpers
		public function get catHouseLevel():int {
			return buildings.catHouse.level;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			if ('buildings' in value) {
				buildings.deserialize(value.buildings);
			}

			if ('resources' in value) {
				resources.deserialize(value.resources);
			}
		}

		public override function serialize():Object {
			var result:Object = super.serialize();
			result['buildings'] = buildings.serialize();
			result['resources'] = resources.serialize();
			return result;
		}
	}
}
