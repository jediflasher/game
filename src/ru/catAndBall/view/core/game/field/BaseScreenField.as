//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game.field {

	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.screens.BaseScreenFieldData;
	import ru.catAndBall.view.core.game.FieldFooterBar;
	import ru.catAndBall.view.core.game.GridController;
	import ru.catAndBall.view.layout.Layout;
	import ru.catAndBall.view.screens.BaseScreen;

	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 18:05
	 */
	public class BaseScreenField extends BaseScreen {

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

		public function BaseScreenField(data:BaseScreenFieldData) {
			super(data);
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		private var _fieldController:GridController;

		public function get fieldController():GridController {
			return _fieldController;
		}

		public function get screenData():BaseScreenFieldData {
			return (data as BaseScreenFieldData);
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _bg:DisplayObject;

		protected var _progressPanel:FieldProgressPanel;

		private var _counterContainer:FieldCounters;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {
			footerClass = FieldFooterBar;

			_progressPanel = new FieldProgressPanel();
			addRawChild(_progressPanel);

			_bg = getBackground();
			_bg.y = Layout.field.fieldBgBounds.y;
			addRawChild(_bg);

			_fieldController = new GridController(screenData.gridData, this);
			_fieldController.added();

			_counterContainer = new FieldCounters((data as BaseScreenFieldData).gridData);
			_counterContainer.touchable = false;
			_counterContainer.y = Layout.field.countersY;
			addRawChild(_counterContainer);

			_fieldController.added();

			super.initialize();
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				update();
			}

			super.draw();
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected function update(event:* = null):void {
			const fieldData:GridData = screenData.gridData;

			fieldData.addEventListener(GridData.EVENT_TURN_UPDATE, updateTurn);
			updateTurn(event);
		}

		protected function getBackground():GridBackground {
			throw "must be implemented";
		}

		protected override function feathersControl_removedFromStageHandler(event:Event):void {
			super.feathersControl_removedFromStageHandler(event);

			_fieldController.removed();
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function updateTurn(event:* = null):void {
			_progressPanel.progress = screenData.gridData.currentTurn / screenData.gridData.maxTurns;
			_progressPanel.stepsLeft = screenData.gridData.maxTurns - screenData.gridData.currentTurn;
		}
	}
}
