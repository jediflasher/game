package ru.catAndBall.view.core.ui {
	import feathers.controls.Header;
	import feathers.controls.supportClasses.LayoutViewPort;
	import feathers.core.IFeathersControl;
	import feathers.display.TiledImage;

	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.DisplayObject;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.11.14 8:52
	 */
	public class BaseFooterBar extends Header {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseFooterBar() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		protected var _items:Vector.<DisplayObject>;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			var bg:TiledImage = new TiledImage(Assets.getTexture(AssetList.Footer_pannel_pattern));
			bg.width = AppProperties.appWidth;
			backgroundSkin = bg;

			paddingRight = paddingLeft = AppProperties.viewRect.x + Layout.baseGap;

			if (_items) {
				for each (var item:DisplayObject in _items) addChild(item);
			}

			super.initialize();
		}

		protected override function draw():void {
			super.draw();

			if (isInvalid(INVALIDATION_FLAG_LAYOUT)) {
				const bounds:Rectangle = backgroundSkin.getBounds(backgroundSkin);
				const maxWidth:Number = AppProperties.viewRect.width - (Layout.baseGap * 2);

				const hashBounds:Dictionary = new Dictionary(true);
				var totalWidth:Number = 0;
				var totalItems:int;

				for each (var item:DisplayObject in _items) {
					if (item is IFeathersControl) (item as IFeathersControl).validate();
					var itemBounds:Rectangle = item.getBounds(item);
					hashBounds[item] = itemBounds;
					totalWidth += itemBounds.width;
					totalItems += 1;
				}

				const itemsGap:int = (maxWidth - totalWidth) / (totalItems - 1);
				var startX:Number = AppProperties.viewRect.x + Layout.baseGap;

				for each (item in _items) {
					itemBounds = hashBounds[item];
					item.x = startX;
					item.y = bounds.height / 2 - itemBounds.height / 2 + 5;
					startX += itemsGap + itemBounds.width;
				}
			}
		}
	}
}
