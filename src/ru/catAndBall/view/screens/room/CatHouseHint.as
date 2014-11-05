package ru.catAndBall.view.screens.room {
	import feathers.controls.Panel;
	import feathers.controls.Scroller;
	import feathers.layout.VerticalLayout;

	import ru.catAndBall.data.game.buildings.CatHouseData;
	import ru.catAndBall.utils.SecondsTimer;
	import ru.catAndBall.utils.TimeUtil;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.TextFieldIcon;
	import ru.catAndBall.view.core.text.TextFieldTest;
	import ru.catAndBall.view.core.utils.L;

	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.09.14 21:09
	 */
	public class CatHouseHint extends Panel {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CatHouseHint(data:CatHouseData) {
			super();
			horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.data = data;

			const layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;

			this.layout = layout;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var data:CatHouseData;

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _nameTextField:TextFieldTest;

		private var _descTextField:TextFieldTest;

		private var _levelTextField:TextFieldIcon;

		private var _timeTextField:TextFieldIcon;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function feathersControl_addedToStageHandler(event:Event):void {
			super.feathersControl_addedToStageHandler(event);

			SecondsTimer.addCallBack(updateTimer);
			update();
		}

		protected override function feathersControl_removedFromStageHandler(event:Event):void {
			SecondsTimer.removeCallback(updateTimer);

			super.feathersControl_removedFromStageHandler(event);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function update():void {
			if (!_nameTextField) {
				_nameTextField = new TextFieldTest();
				_nameTextField.text = L.get('CAT HOUSE');
				addChild(_nameTextField);
			}

			if (!_descTextField) {
				_descTextField = new TextFieldTest();
				_descTextField.text = L.get('VERY CUTE BED');
				addChild(_descTextField);
			}

			if (!_levelTextField) {
				_levelTextField = new TextFieldIcon(new TextFieldTest(), Assets.getImage(AssetList.hint_lvl_icon));
				_levelTextField.text = L.get('LEVEL %s', [data.level]);
				addChild(_levelTextField);
			}

			if (!_timeTextField) {
				_timeTextField = new TextFieldIcon(new TextFieldTest(), Assets.getImage(AssetList.hint_clock_icon));
				addChild(_timeTextField);
			}

			updateTimer();
		}

		private function updateTimer():void {
			var tl:Number = data.bonusTimeLeft;
			var t:String = tl > 0 ? TimeUtil.stringify(tl) : L.get('Done!');
			_timeTextField.text = t;
		}
	}
}
