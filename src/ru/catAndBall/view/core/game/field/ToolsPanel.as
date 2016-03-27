package ru.catAndBall.view.core.game.field {
	
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScrollContainer;
	import feathers.core.FeathersControl;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.dict.CommodeShelfDict;
	import ru.catAndBall.data.dict.tools.ToolDict;
	import ru.catAndBall.data.game.field.GridData;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.ui.BaseButton;
	
	import starling.events.Event;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                17.03.15 9:14
	 */
	public class ToolsPanel extends LayoutGroup {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const GAP:int = 50;

		public static const EVENT_EXPAND_COLLAPSE:String = 'eventExpandCollapse';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ToolsPanel(data:GridData) {
			super();
			this._data = data;

			super.layout = new AnchorLayout();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _data:GridData;

		private var _iconContainer:ScrollContainer;

		private var _toolIcons:Vector.<ApplyToolIcon> = new Vector.<ApplyToolIcon>();

		private var _buttonLeft:Button;

		private var _buttonRight:Button;

		private var _helpButton:Button;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _collapsed:Boolean = true;

		public function get collapsed():Boolean {
			return _collapsed;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			var d:AnchorLayoutData = new AnchorLayoutData();
			d.verticalCenter = 0;
			d.left = AppProperties.viewRect.x + GAP;
			_buttonLeft = new BaseButton(AssetList.panel_tools_toolsPointerLeft, AssetList.panel_tools_toolsPointerLeft_on, AssetList.panel_tools_toolsPointerLeft_Disabled);
			_buttonLeft.layoutData = d;
			_buttonLeft.addEventListener(Event.TRIGGERED, this.handler_pressLeft);
			addChild(_buttonLeft);

			d = new AnchorLayoutData();
			d.verticalCenter = 0;
			d.horizontalCenter = 0;
			_iconContainer = new ScrollContainer();
			_iconContainer.layoutData = d;
			_iconContainer.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			_iconContainer.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			_iconContainer.maxWidth = AppProperties.viewRect.width - 530;
			_iconContainer.height = 400;
			addChild(_iconContainer);

			var targetShelf:CommodeShelfDict;
			if (_data === GameData.player.ballsField) {
				targetShelf = GameData.player.constructions.commode1.proto as CommodeShelfDict;
			} else if (_data === GameData.player.rugField) {
				targetShelf = GameData.player.constructions.commode2.proto as CommodeShelfDict;
			} else if (_data === GameData.player.windowField) {
				targetShelf = GameData.player.constructions.commode3.proto as CommodeShelfDict;
			}

			var tools:Vector.<ToolDict> = targetShelf.tools;
			for each (var tool:ToolDict in tools) {
				var icon:ApplyToolIcon = new ApplyToolIcon(tool);
				_iconContainer.addChild(icon);
				_toolIcons.push(icon);
			}

			d = new AnchorLayoutData();
			d.right = AppProperties.viewRect.x + GAP;
			d.verticalCenter = 0;
			_buttonRight = new BaseButton(AssetList.panel_tools_toolsPointerRight, AssetList.panel_tools_toolsPointerRight_on, AssetList.panel_tools_toolsPointerRight_Disabled);
			_buttonRight.layoutData = d;
			_buttonRight.addEventListener(Event.TRIGGERED, this.handler_pressRight);
			addChild(_buttonRight);

			d = new AnchorLayoutData();
			d.top = 35;
			d.right = AppProperties.viewRect.x + GAP + 5;
			_helpButton = Assets.getButton(AssetList.buttons_InfoIcon);
			_helpButton.layoutData = d;
			_helpButton.addEventListener(Event.TRIGGERED, handler_helpClick);
			addChild(_helpButton);
		}


		override protected function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_LAYOUT)) {
				if (_collapsed) {
					var hl:HorizontalLayout = new HorizontalLayout();
					hl.gap = 10;
					_iconContainer.layout = hl;
					_iconContainer.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
					_iconContainer.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
					_iconContainer.width = AppProperties.viewRect.width - _buttonLeft.width - _buttonRight.width - GAP * 4;
					_iconContainer.height = 400;
				} else {
					var vl:VerticalLayout = new VerticalLayout();
					vl.paddingTop = 50;
					vl.paddingBottom = 50;
					vl.gap = 50;
					vl.hasVariableItemDimensions = true;
					_iconContainer.layout = vl;
					_iconContainer.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
					_iconContainer.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
					_iconContainer.width = AppProperties.baseWidth;
					_iconContainer.height = 1150;
				}

				_buttonLeft.visible = _buttonRight.visible = _collapsed;

				for each (var icon:ApplyToolIcon in _toolIcons) {
					icon.expanded = !_collapsed;
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_pressLeft(event:Event):void {
			var pos:Number = Math.max(_iconContainer.horizontalScrollPosition - 190, _iconContainer.minHorizontalScrollPosition);
			this._iconContainer.scrollToPosition(pos, 0, 0.2);
		}

		private function handler_pressRight(event:Event):void {
			var pos:Number = Math.min(_iconContainer.horizontalScrollPosition + 190, _iconContainer.maxHorizontalScrollPosition);
			this._iconContainer.scrollToPosition(pos, 0, 0.2);
		}

		private function handler_helpClick(event:Event):void {
			_collapsed = !_collapsed;
			invalidate(FeathersControl.INVALIDATION_FLAG_LAYOUT);
			dispatchEventWith(EVENT_EXPAND_COLLAPSE, true);
		}
	}
}
