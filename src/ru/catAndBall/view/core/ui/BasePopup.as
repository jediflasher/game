package ru.catAndBall.view.core.ui {
	
	import feathers.core.FeathersControl;
	import feathers.core.IFeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.display.TiledImage;
	
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

		private var _bgTop:Image;

		private var _bgCenter:TiledImage;

		private var _bgBottom:Image;

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


			_bgTop = Assets.getImage(AssetList.popup_popup1);
			addChild(_bgTop);

			_bgCenter = new TiledImage(Assets.getTexture(AssetList.popup_popup2));
			addChild(_bgCenter);

			_bgBottom = Assets.getImage(AssetList.popup_popup3);
			addChild(_bgBottom);

			_w = _bgTop.texture.width;
			updateCloseButton();
		}

		protected override function draw():void {
			if (isInvalid(INVALIDATION_FLAG_LAYOUT)) {
				if (_closeButton) addChild(_closeButton);

				var nextY:int = _bgTop.texture.height - Layout.popup.topYOffset;
				var totalHeight:Number = 0;

				updateCloseButton();
				addChild(_icon);

				if (_content) {
					for each (var child:DisplayObject in _content) child.parent.removeChild(child);
				}

				_content = getContent();
				if (_content) {
					for each (var obj:DisplayObject in _content) {
						addChild(obj);

						if (obj is ITextRenderer) {
							(obj as ITextRenderer).wordWrap = true;
							(obj as ITextRenderer).maxWidth = Layout.popup.contentWidth;
						}

						this.validateContainer(obj);

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
						totalHeight += h;
					}
				}

				updateBackground(totalHeight);
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

				_closeButton.x = Layout.popup.closeButtonPosition.x;
				_closeButton.y = Layout.popup.closeButtonPosition.y;
				_closeButton.addEventListener(Event.TRIGGERED, handler_closeClick);
				addChild(_closeButton);
			}
		}

		private function updateBackground(contentHeight:Number):void {
			var additionalBottomPlace:Number = 100;
			var th:Number = _bgTop.texture.height;
			var bh:Number = _bgBottom.texture.height;

			_h = (th - Layout.popup.topYOffset) + (contentHeight - additionalBottomPlace) + bh;

			var centerHeight:Number = contentHeight - additionalBottomPlace - Layout.popup.topYOffset;
			_bgCenter.height = centerHeight;

			_bgCenter.y = th;
			_bgBottom.y = th + centerHeight;
		}

		private function validateContainer(container:DisplayObject):void {
			var cont:DisplayObjectContainer = container as DisplayObjectContainer;

			if (cont) {
				var numChildren:int = cont.numChildren;
				for (var i:int = 0; i < numChildren; i++) {
					var child:DisplayObject = cont.getChildAt(i);
					validateContainer(child);
				}
			}

			if (container is IFeathersControl) {
				(container as IFeathersControl).validate();
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
