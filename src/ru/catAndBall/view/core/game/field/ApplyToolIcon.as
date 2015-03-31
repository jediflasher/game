package ru.catAndBall.view.core.game.field {
	import feathers.controls.Button;
	import feathers.core.FeathersControl;

	import ru.catAndBall.AppProperties;

	import ru.catAndBall.data.GameData;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.dict.tools.ToolDict;
	import ru.catAndBall.utils.s;
	import ru.catAndBall.utils.str;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.TiledImage;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.ui.SmallGreenButton;

	import starling.display.Image;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.03.15 9:58
	 */
	public class ApplyToolIcon extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const GAP:int = 30;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ApplyToolIcon(data:ToolDict) {
			super();

			_data = data;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _icon:ResourceCounter;

		private var _title:BaseTextField;

		private var _description:BaseTextField;

		private var _buyButton:Button;

		private var _border:Image;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _data:ToolDict;

		public function get data():ToolDict {
			return _data;
		}

		private var _expanded:Boolean = false;

		public function get expanded():Boolean {
			return _expanded;
		}

		public function set expanded(value:Boolean):void {
			if (_expanded == value) return;

			_expanded = value;
			invalidate(FeathersControl.INVALIDATION_FLAG_SIZE);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_border = Assets.getImage(AssetList.panel_tools_panelTool_shelf);
			addChild(_border);

			_icon = new ResourceCounter(_data.resourceType, GameData.player.resources);
			_icon.y = 85;
			addChild(_icon);

			_title = new BaseTextField(AssetList.font_large_white_shadow);
			_title.text = str(_data.name);
			addChild(_title);

			_description = new BaseTextField(AssetList.font_medium_milk_shadow);
			_description.text = 'Is there a way to do my layout in Flash Pro and then ' +
			'import it into Starling? ... Well, actually I\'d like to change the ' +
			'request to just use the Flash IDE is a "smart" way -- to ... Add ' +
			'in TweenMax to animate it on and off, and you\'re g';//_data.description;

			_description.wordWrap = true;
			_description.y = 85;
			addChild(_description);

			_buyButton = new SmallGreenButton('buy');
			_buyButton.touchable = false;
			addChild(_buyButton);
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(FeathersControl.INVALIDATION_FLAG_SIZE)) {
				if (_expanded) {
					_title.visible = true;
					_description.visible = true;
					_icon.validate();
					_buyButton.visible = false;

					_icon.x = AppProperties.viewRect.x + GAP;
					_title.x = _icon.x + _icon.width + GAP;
					_description.x = _title.x;

					var w:Number = AppProperties.viewRect.width - _icon.width - GAP * 3;
					_title.width = w;
					_description.width = w;

					_title.validate();
					_description.validate();

					var wid:Number = AppProperties.baseWidth;
					var hei:Number = Math.max(_description.y + _description.height, _icon.y + _icon.height);

					_border.visible = true;
					_border.y = hei - _border.texture.height;

					setSizeInternal(wid, hei, false);
				} else {
					_title.visible = false;
					_description.visible = false;

					_buyButton.visible = _icon.count == 0;
					_buyButton.validate();
					_buyButton.x = _icon.width / 2 - _buyButton.width / 2;
					_buyButton.y = _icon.height / 2 - _buyButton.height / 2;

					_border.visible = false;

					_icon.validate();
					setSizeInternal(_icon.width, _icon.height, false);
				}


			}
		}
	}
}
