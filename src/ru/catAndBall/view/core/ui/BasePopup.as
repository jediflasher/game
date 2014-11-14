package ru.catAndBall.view.core.ui {
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.IFeathersControl;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                08.11.14 11:38
	 */
	public class BasePopup extends FeathersControl {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_CLOSE_CLICK:String = 'eventCloseClick';

		public static const EVENT_BUTTON_CLICK:String = 'eventButtonClick';

		private static const HELPER_RECT:Rectangle = new Rectangle();

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BasePopup() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _bg:Scale3Image;

		private var _closeButton:YellowButton;

		private var _w:Number;

		private var _h:Number;

		private var _content:Vector.<DisplayObject>;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public override function get width():Number {
			return _w;
		}

		public override function get height():Number {
			return _h;
		}

		private var _icon:Image;

		public function get icon():Image {
			return _icon;
		}

		public function set icon(value:Image):void {
			if (_icon == value) return;
			if (_icon && value && _icon.texture === value.texture) return;

			if (_icon) removeChild(_icon);
			_icon = value;

			const iconPos:Point = Layout.popup.iconPosition;
			_icon.alignPivot();
			_icon.x = iconPos.x;
			_icon.y = iconPos.y;

			addChild(_icon);
		}

		private var _showClose:Boolean = true;

		public function get showClose():Boolean {
			return _showClose;
		}

		public function set showClose(value:Boolean):void {
			if (_showClose == value) return;

			_showClose = value;
			if (!_showClose && !_closeButton) return;

			updateCloseButton();
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			const sizes:Array = Layout.popup.bgScaleGridSizes;
			const t:Texture = Assets.getTexture(AssetList.start_windows_bg_start_window);
			_bg = new Scale3Image(new Scale3Textures(t, sizes[0], sizes[1], Scale3Textures.DIRECTION_VERTICAL));
			addChild(_bg);

			_w = _bg.textures.texture.width;
			updateCloseButton();
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_LAYOUT)) {
				if (_closeButton) addChild(_closeButton);

				var nextY:int = Layout.popup.contentY;

				updateCloseButton();
				addChild(_icon);

				if (_content) {
					for each (var child:DisplayObject in _content) child.parent.removeChild(child);
				}

				_content = getContent();
				if (_content) {
					for each (var obj:DisplayObject in _content) {
						addChild(obj);

						if (obj is BitmapFontTextRenderer) {
							(obj as BitmapFontTextRenderer).wordWrap = true;
							(obj as BitmapFontTextRenderer).maxWidth = Layout.popup.contentWidth;
						}

						if (obj is IFeathersControl) (obj as IFeathersControl).validate();

						var w:Number = 0;
						var h:Number = 0;

						if (obj is GridLayoutContainer) {
							w = obj.width;
							h = obj.height;
						} else {
							obj.getBounds(obj, HELPER_RECT);
							w = HELPER_RECT.width;
							h = HELPER_RECT.height;
						}

						obj.x = _w / 2 - w / 2;
						obj.y = nextY;

						nextY += h + Layout.popup.contentGap;
					}
				}

				const bgHeight:Number = nextY + Layout.popup.bgBottomHeight;
				_bg.height = Math.max(bgHeight, _bg.textures.texture.height);

				_h = bgHeight;
			}

			super.draw();
		}

		protected function getContent():Vector.<DisplayObject> {
			return null;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		private function updateCloseButton():void {
			if (!_showClose) {
				if (_closeButton && _closeButton.parent) {
					removeChild(_closeButton);
					_closeButton.removeEventListener(BasePopup.EVENT_CLOSE_CLICK, handler_closeClick);
				}
			} else {
				if (!_closeButton) _closeButton = new YellowButton(AssetList.buttons_close);

				_closeButton.x = Layout.popup.closeButtonPosition.x - _closeButton.width / 2;
				_closeButton.y = Layout.popup.closeButtonPosition.y - _closeButton.height / 2;
				_closeButton.addEventListener(Event.TRIGGERED, handler_closeClick);
				addChild(_closeButton);
			}
		}

		private function invalidateContainer(container:DisplayObjectContainer):void {
			if (container is IFeathersControl) {

			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_closeClick(event:Event):void {
			dispatchEventWith(EVENT_CLOSE_CLICK);
		}
	}
}
