//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.ballsField {

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.core.game.field.BaseScreenField;
	import ru.catAndBall.view.core.game.field.BaseScreenFieldBackground;
	import ru.catAndBall.view.core.game.field.ObjectsCounter;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                14.08.14 22:05
	 */
	public class ScreenBallsField extends BaseScreenField {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenBallsField(data:BaseScreenData) {
			super(data);
		}

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {


			super.initialize();
		}

		protected override function update(event:* = null):void {
			super.update();
			updateCounters();
		}

		protected override function getBackground():BaseScreenFieldBackground {
			return new BaseScreenFieldBackground(
					AssetList.Strip_moves_strip_moves,
					AssetList.fields_balls_bg1,
					AssetList.fields_balls_bg2,
					AssetList.fields_balls_bg3,
					AssetList.fields_balls_ebge_fieldballs,
					AssetList.fields_balls_ebge_fieldballs,
					GameData.player.ballsField.columns,
					GameData.player.ballsField.rows
			);
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function updateCounters(event:* = null):void {
			if (!fieldData) return;

			var socks:ObjectsCounter = getCounter(ResourceSet.BF_SOCKS);
			var sweaters:ObjectsCounter = getCounter(ResourceSet.BF_SWEATERS);
			var balls:ObjectsCounter = getCounter(ResourceSet.BF_BALLS);
			var toys:ObjectsCounter = getCounter(ResourceSet.BF_TOYS);

			var stackSize:int = 8;

			var count:int = fieldData.getCollectedResource(ResourceSet.BF_BALLS);
			balls.count = int(count / stackSize);
			balls.progress = ((stackSize + count) % stackSize) / stackSize;

			count = fieldData.getCollectedResource(ResourceSet.BF_SWEATERS);
			sweaters.count = int(count / stackSize);
			sweaters.progress = ((stackSize + count) % stackSize) / stackSize;

			count = fieldData.getCollectedResource(ResourceSet.BF_SOCKS);
			socks.count = int(count / stackSize);
			socks.progress = ((stackSize + count) % stackSize) / stackSize;

			count = fieldData.getCollectedResource(ResourceSet.BF_TOYS);
			toys.count = int(count / stackSize);
			toys.progress = ((stackSize + count) % stackSize) / stackSize;
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
