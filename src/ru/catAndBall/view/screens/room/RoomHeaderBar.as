package ru.catAndBall.view.screens.room {
	import feathers.controls.Header;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.TiledImage;
	import ru.catAndBall.view.core.text.TextFieldIcon;
	import ru.catAndBall.view.core.text.TextFieldTest;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;

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
			init();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:TiledImage;

		private var _nameTextField:TextFieldIcon;

		private var _levelCounter:TextFieldIcon;

		private var _mouseCounter:TextFieldIcon;

		private var _moneyCounter:TextFieldIcon;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		private function init():void {
			_bg = new TiledImage(Assets.getTexture(AssetList.header_pannel_pattern));
			_bg.width = AppProperties.appWidth;
			backgroundSkin = _bg;

			var texture:Texture = Assets.getTexture(AssetList.header_header_counter_background);

			const iconSize:int = Layout.room.headerIconSize;
			var img:Image = Assets.getImage(AssetList.header_header_icon_ava);
			_nameTextField = new TextFieldIcon(new TextFieldTest(), img);
			_nameTextField.text = 'lalapaluza';

			img = Assets.getImage(AssetList.header_header_lvlIcon, iconSize, iconSize);
			_levelCounter = new TextFieldIcon(new TextFieldTest(), img, new Image(texture), texture.height);
			_levelCounter.text = String(GameData.player.level);

			img = Assets.getImage(AssetList.header_header_mouseIcon, iconSize, iconSize);
			_mouseCounter = new TextFieldIcon(new TextFieldTest(), img, new Image(texture), texture.height);
			_mouseCounter.text = '0';

			img = Assets.getImage(AssetList.header_catmoneyIcon, iconSize, iconSize);
			_moneyCounter = new TextFieldIcon(new TextFieldTest(), img, new Image(texture), texture.height);
			_moneyCounter.text = String(GameData.player.resources.get(ResourceSet.MONEY));

			paddingLeft = AppProperties.viewRect.x;
			paddingRight = paddingLeft;
			gap = 10;
			leftItems = new <DisplayObject>[_nameTextField];
			rightItems = new <DisplayObject>[_levelCounter, _moneyCounter, _mouseCounter];

		}
	}
}
