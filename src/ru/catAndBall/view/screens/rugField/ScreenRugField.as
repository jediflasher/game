//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.rugField {

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
	 * @date                07.06.14 19:20
	 */
	public class ScreenRugField extends BaseScreenField {

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

		public function ScreenRugField(data:BaseScreenData) {
			super(data);
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected override function update(event:* = null):void {
			super.update();
			updateCounters();
		}

		protected override function initialize():void {
			if (!super.getCounter(ResourceSet.RF_BALL)) {
				super.addCounter(
						ResourceSet.RF_BALL,
						AssetList.fields_carpet_components_screenFieldCarpet_ballIcon,
						AssetList.fields_carpet_components_screenFieldCarpet_ballIconDisabled
				);
				super.addCounter(
						ResourceSet.RF_COOKIE,
						AssetList.fields_carpet_components_screenFieldCarpet_cookieIcon,
						AssetList.fields_carpet_components_screenFieldCarpet_cookieIconDisabled
				);
				super.addCounter(
						ResourceSet.RF_MOUSE,
						AssetList.fields_carpet_components_screenFieldCarpet_mouseIcon,
						AssetList.fields_carpet_components_screenFieldCarpet_mouseIconDisabled
				);
				super.addCounter(
						ResourceSet.RF_SAUSAGE,
						AssetList.fields_carpet_components_screenFieldCarpet_sausageIcon,
						AssetList.fields_carpet_components_screenFieldCarpet_sausageIconDisabled
				);
				super.addCounter(
						ResourceSet.RF_PIGEON,
						AssetList.fields_carpet_components_screenFieldCarpet_doveIcon,
						AssetList.fields_carpet_components_screenFieldCarpet_doveIcon_Disabled
				);
				super.addCounter(
						ResourceSet.RF_CONSERVE,
						AssetList.fields_carpet_components_screenFieldCarpet_cannedIcon,
						AssetList.fields_carpet_components_screenFieldCarpet_cannedIconDisabled
				);
				super.addCounter(
						ResourceSet.RF_WRAPPER,
						AssetList.fields_carpet_components_screenFieldCarpet_wrapperIcon,
						AssetList.fields_carpet_components_screenFieldCarpet_wrapperIconDisabled
				);
				super.addCounter(
						ResourceSet.RF_THREAD,
						AssetList.fields_carpet_components_screenFieldCarpet_threadIcon,
						AssetList.fields_carpet_components_screenFieldCarpet_threadIconDisabled
				);
			}

			super.initialize();
		}

		protected override function getBackground():BaseScreenFieldBackground {
			return new BaseScreenFieldBackground(
					AssetList.Strip_moves_strip_moves,
					AssetList.fields_carpet_bg1,
					AssetList.fields_carpet_bg2,
					AssetList.fields_carpet_bg3,
					AssetList.fields_carpet_tangle_for_bg,
					AssetList.fields_carpet_tangle_for_bg_down,
					GameData.player.rugFieldSettings.fieldWidth,
					GameData.player.rugFieldSettings.fieldHeight
			);
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function updateCounters(event:* = null):void {
			if (!fieldData) return;

			var types:Vector.<String> = new <String>[
				ResourceSet.RF_BALL,
				ResourceSet.RF_COOKIE,
				ResourceSet.RF_MOUSE,
				ResourceSet.RF_SAUSAGE,
				ResourceSet.RF_PIGEON,
				ResourceSet.RF_CONSERVE,
				ResourceSet.RF_WRAPPER,
				ResourceSet.RF_THREAD
			];

			var stackSize:int = 8;

			for each(var type:String in types) {
				var obj:ObjectsCounter = getCounter(type);
				var count:int = fieldData.getCollectedResource(type);
				obj.count = int(count / stackSize);
				obj.progress = ((stackSize + count) % stackSize) / stackSize;
			}
		}
	}
}
