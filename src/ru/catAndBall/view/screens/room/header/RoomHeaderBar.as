package ru.catAndBall.view.screens.room.header {
	
	import feathers.controls.Header;
	import feathers.display.TiledImage;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.text.TextFieldIcon;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                05.10.14 18:33
	 */
	public class RoomHeaderBar extends Header {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function RoomHeaderBar() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:TiledImage;

		private var _nameTextField:TextFieldIcon;

		private var _levelCounter:HeaderCounter;

		private var _mouseCounter:HeaderCounter;

		private var _moneyCounter:HeaderCounter;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_bg = new TiledImage(Assets.getTexture(AssetList.header_headerPannel));
			_bg.width = AppProperties.baseWidth;
			backgroundSkin = _bg;

			var img:Image = Assets.getImage(AssetList.header_catnameBg);
			_nameTextField = new TextFieldIcon(new BaseTextField(AssetList.font_medium_lightgreen), null, img, img.texture.width, img.texture.height);
			_nameTextField.text = 'My best room';

			_levelCounter = new HeaderCounter(AssetList.header_LvlMoneyBg, AssetList.header_header_lvlIcon);
			_mouseCounter = new HeaderCounter(AssetList.header_mouseScoreBg, AssetList.header_header_mouseIcon);
			_mouseCounter.length = 3;
			_moneyCounter = new HeaderCounter(AssetList.header_LvlMoneyBg, AssetList.header_catmoneyIcon);

			GameData.player.resources.addEventListener(Event.CHANGE, handler_resourcesChange);

			var r:Rectangle = AppProperties.viewRect;
			paddingLeft = paddingRight = r.x + 10;
			paddingBottom = 38;
			gap = 0;
			leftItems = new <DisplayObject>[_nameTextField];
			rightItems = new <DisplayObject>[_levelCounter, _mouseCounter, _moneyCounter];
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_DATA)) {
				_levelCounter.value = GameData.player.level;
				_moneyCounter.value = GameData.player.resources.get(ResourceSet.MONEY);
				_mouseCounter.value = GameData.player.resources.get(ResourceSet.MOUSE);
			}

			super.draw();
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_resourcesChange(event:Event):void {
			invalidate(INVALIDATION_FLAG_DATA);
		}
	}
}
