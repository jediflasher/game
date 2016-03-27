package ru.catAndBall.view.core.game.field {
	
	import com.greensock.TweenNano;
	
	import feathers.core.FeathersControl;
	
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	
	import starling.display.Image;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                07.11.14 19:10
	 */
	public class FieldFooter extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function FieldFooter(data:GridData) {
			super();

			_data = data;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:Image;

		private var _data:GridData;

		private var _counterPanel:CountersPanel;

		public var toolsPanel:ToolsPanel;

		private var _isCountersActive:Boolean = true;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function switchPanels():void {
			if (_isCountersActive) {
				TweenNano.to(toolsPanel, 0.2, {alpha: 1});
				TweenNano.to(_counterPanel, 0.2, {alpha: 0});
				_isCountersActive = false
			} else {
				TweenNano.to(toolsPanel, 0.2, {alpha: 0});
				TweenNano.to(_counterPanel, 0.2, {alpha: 1});
				_isCountersActive = true;
			}
		}

		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_bg = Assets.getImage(AssetList.panel_tools_toolDescriptionBG);
			addChild(_bg);

			_counterPanel = new CountersPanel(_data);
			_counterPanel.touchable = false;
			addChild(_counterPanel);

			toolsPanel = new ToolsPanel(_data);
			toolsPanel.width = AppProperties.baseWidth;
			toolsPanel.y = 0;
			toolsPanel.alpha = 0;
			addChild(toolsPanel);
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_LAYOUT)) {
				_counterPanel.validate();
				_counterPanel.x = AppProperties.viewRect.x + AppProperties.viewRect.width / 2 - _counterPanel.width / 2;

				toolsPanel.validate();
				toolsPanel.x = 0;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
	}
}
