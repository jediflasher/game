//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game.field {

	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.field.GridCellType;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.data.game.screens.BaseScreenFieldData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.FieldBottomPanel;
	import ru.catAndBall.view.core.game.GridCell;
	import ru.catAndBall.view.core.game.GridField;
	import ru.catAndBall.view.screens.BaseScreen;

	import starling.display.Image;
	import starling.display.Sprite;
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

		private var _fieldView:GridField;

		public function get fieldView():GridField {
			return _fieldView;
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		protected var _progressPanel:FieldProgressPanel;

		private var _hashTypeToCounter:Object = {}; // type (String) -> ObjectsCounter

		private var _counterContainer:Sprite = new Sprite();

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			backgroundSkin = getBackground();
			headerClass = FieldProgressPanel;
			footerClass = FieldBottomPanel;

			_fieldView = new GridField();
			_fieldView.data
			_fieldView.addEventListener(GridField.EVENT_HIGHLIGHT_START, handler_highlightStart);
			_fieldView.addEventListener(GridField.EVENT_HIGHLIGHT_COMPLETE, handler_highlightComplete);
			addRawChild(_fieldView);

			_counterContainer.touchable = false;
			addRawChild(_counterContainer);

			_progressPanel = new FieldProgressPanel();
			addRawChild(_progressPanel);

			const settings:GridFieldSettings = (data as BaseScreenFieldData).fieldData.settings;

			for (var key:String in settings.upgradeHash) {
				var resourceType:String = GridCellType.getResourceType(int(key));
				addCounter(resourceType);
			}

			this.update();
		}

		public function addCounter(resourceType:String):void {
			if (resourceType in _hashTypeToCounter) return;

			var counter:ObjectsCounter = new ObjectsCounter(resourceType);
			counter.x = _counterContainer.width;
			_counterContainer.addChild(counter);

			_hashTypeToCounter[resourceType] = counter;
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected function update(event:* = null):void {
			const fieldData:GridData = (data as BaseScreenFieldData).fieldData;

			fieldData.addEventListener(GridData.EVENT_UPDATE_FIELD, update);
			fieldData.addEventListener(GridData.EVENT_TURN_UPDATE, updateTurn);

			updateFieldPosition();
			updateCountersPosition();
			updateTurn(event);
		}

		protected function getBackground():BaseScreenFieldBackground {
			throw "must be implemented";
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function updateFieldPosition():void {
			var bounds:Rectangle = _fieldView.getBounds(_fieldView);

			_fieldView.x = AppProperties.appWidth / 2 - bounds.width / 2 + GridCell.SIZE / 2;
			_fieldView.y = AppProperties.appHeight * 0.14;
		}

		private function updateCountersPosition():void {
			_counterContainer.x = AppProperties.appWidth / 2 - _counterContainer.width / 2;
//			_counterContainer.y = _countsBg.y;
		}

		private function updateTurn(event:* = null):void {
			if (!fieldData) return;

			_progressPanel.progress = fieldData.currentTurn / fieldData.maxTurns;
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------

		private function handler_highlightStart(event:Event):void {
			darken();
			addChild(_fieldView);
		}

		private function handler_highlightComplete(event:Event):void {
			undarken();
		}
	}
}
