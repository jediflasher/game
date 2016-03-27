//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game.field {
	
	import airlib.view.core.BaseScreen;

	import feathers.display.TiledImage;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.data.game.screens.BaseScreenFieldData;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.FieldFooterBar;
	import ru.catAndBall.view.core.game.GridContainer;

	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

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

		private static const PANEL_Y:Number = 1500;

		private static const PANEL_Y_EXPANDED:Number = 735;

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseScreenField(screenType:String, data:BaseScreenFieldData) {
			super(screenType);
			_data = data;
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		private var _fieldContainer:GridContainer;

		public function get fieldContainer():GridContainer {
			return _fieldContainer;
		}

		private var _data:BaseScreenFieldData;

		public function get data():BaseScreenFieldData {
			return _data;
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _border:DisplayObject;

		protected var _progressPanel:FieldProgressPanel;

		private var _footer:FieldFooter;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {
//			footerClass = FieldFooterBar;
//
//			_fieldContainer = new GridContainer(_data.gridData, getBackground());
//			_fieldContainer.y = 170;
//			addRawChild(_fieldContainer);
//
//			_progressPanel = new FieldProgressPanel();
//			addRawChild(_progressPanel);
//
//			_footer = new FieldFooter((data as BaseScreenFieldData).gridData);
//			_footer.addEventListener(ToolsPanel.EVENT_EXPAND_COLLAPSE, handler_expandCollapse);
//			_footer.y = PANEL_Y;
//			addRawChild(_footer);
//
//			_border = new TiledImage(Assets.getTexture(getBorder()));
//			_border.alignPivot(HAlign.LEFT, VAlign.CENTER);
//			_border.width = AppProperties.baseWidth;
//			_border.x = 0;
//			_border.y = PANEL_Y + 20;
//			addRawChild(_border);
//
			addEventListener(FieldFooterBar.EVENT_TOOLS_CLICK, handler_toolsClick);

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
			var fieldData:GridData = _data.gridData;

			fieldData.addEventListener(GridData.EVENT_TURN_UPDATE, updateTurn);
			updateTurn(event);
		}

		protected override function feathersControl_removedFromStageHandler(event:Event):void {
			super.feathersControl_removedFromStageHandler(event);

			_fieldContainer.clear();
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function updateTurn(event:* = null):void {
			_progressPanel.progress = _data.gridData.currentTurn / _data.gridData.maxTurns;
			_progressPanel.stepsLeft = _data.gridData.maxTurns - _data.gridData.currentTurn;
		}

		private function handler_toolsClick(event:*):void {
			_footer.switchPanels();
		}

		private function handler_expandCollapse(event:*):void {
			setChildIndex(_footer, numChildren - 1);
			_footer.y = _footer.toolsPanel.collapsed ? PANEL_Y : PANEL_Y_EXPANDED;
			_border.y = _footer.y + 20;
		}
	}
}
