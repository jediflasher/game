//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens {

	import feathers.controls.PanelScreen;
	import feathers.core.IFeathersControl;

	import flash.display.BitmapData;

	import ru.catAndBall.AppProperties;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.ui.BasePopup;

	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                07.06.14 19:54
	 */
	public class BaseScreen extends PanelScreen {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const DARKEN_TEXTURE:Texture = Texture.fromBitmapData(new BitmapData(1, 1, true, 0xCC000000));

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseScreen(data:BaseScreenData, background:String = null) {
			super();
			this._data = data;
			horizontalScrollPolicy = PanelScreen.SCROLL_POLICY_OFF;
			verticalScrollPolicy = PanelScreen.SCROLL_POLICY_OFF;

			_bg = background ? background : data.type + '_bg';
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		public var headerClass:Class;

		public var footerClass:Class;

		private var _bg:String;

		private var _darkenImage:Image;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		private var _data:BaseScreenData;

		public function get data():BaseScreenData {
			return this._data;
		}

		public function set data(value:BaseScreenData):void {
			if (this._data == value) return;

			_data = value;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function darken(alpha:Number = 1):void {
			addRawChild(_darkenImage);
			_darkenImage.alpha = alpha;
			_darkenImage.visible = true;
		}

		public function undarken():void {
			_darkenImage.visible = false;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			if (headerClass) headerFactory = customHeaderFactory;
			if (footerClass) footerFactory = customFooterFactory;

			if (Assets.hasTexture(_bg)) {
				backgroundSkin = Assets.getImage(_bg);
				backgroundSkin.width = AppProperties.appWidth;
				backgroundSkin.height = AppProperties.appHeight;
			}

			if (!_darkenImage) {
				_darkenImage = new Image(DARKEN_TEXTURE);
				_darkenImage.width = AppProperties.appWidth;
				_darkenImage.height = AppProperties.appHeight;
				_darkenImage.visible = false;
			}

			super.initialize();
		}

		protected function customHeaderFactory():IFeathersControl {
			return IFeathersControl(new headerClass());
		}

		protected function customFooterFactory():IFeathersControl {
			return IFeathersControl(new footerClass());
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
	}
}
