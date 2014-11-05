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
	import ru.catAndBall.view.layout.Layout;
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

		public function get screenData():BaseScreenFieldData {
			return (data as BaseScreenFieldData);
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
			backgroundSkin = getBackground();
			headerClass = FieldProgressPanel;
			footerClass = FieldBottomPanel;

			super.initialize();

			_fieldView = new GridField(screenData.gridData);
			_fieldView.addEventListener(GridField.EVENT_HIGHLIGHT_START, handler_highlightStart);
			_fieldView.addEventListener(GridField.EVENT_HIGHLIGHT_COMPLETE, handler_highlightComplete);
			_fieldView.y = Layout.fieldFieldY;
			addRawChild(_fieldView);

			_progressPanel = new FieldProgressPanel();
			addRawChild(_progressPanel);

			_counterContainer.touchable = false;
			addRawChild(_counterContainer);

			const settings:GridFieldSettings = (data as BaseScreenFieldData).gridData.settings;

			var x:int = 0;
			for (var key:String in settings.upgradeHash) {
				var resourceType:String = GridCellType.getResourceType(int(key));

				if (resourceType in _hashTypeToCounter) return;

				var counter:ObjectsCounter = new ObjectsCounter(
						resourceType,
						screenData.gridData.collectedResourceSet,
						screenData.gridData.settings.baseStackSize
				);

				counter.x = x;
				x += counter.width + Layout.baseGap;

				_counterContainer.addChild(counter);
				_hashTypeToCounter[resourceType] = counter;
			}

			_counterContainer.x = AppProperties.appWidth / 2 - x / 2;
			_counterContainer.y = Layout.fieldCountersY;

			this.update();
		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------

		protected function update(event:* = null):void {
			const fieldData:GridData = screenData.gridData;

			fieldData.addEventListener(GridData.EVENT_UPDATE_FIELD, update);
			fieldData.addEventListener(GridData.EVENT_TURN_UPDATE, updateTurn);

			updateFieldPosition();
			updateCounters();
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

		private function updateTurn(event:* = null):void {
			_progressPanel.progress = screenData.gridData.currentTurn / screenData.gridData.maxTurns;
		}

		private function updateCounters(event:* = null):void {
			for (var resourceType:String in _hashTypeToCounter) {
				var counter:ObjectsCounter = _hashTypeToCounter[resourceType] as ObjectsCounter;
				counter.stack = screenData.gridData.getCollectedResource(resourceType);
			}
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
