package ru.catAndBall.view.screens.craft {
	import feathers.controls.Button;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.supportClasses.LayoutViewPort;
	import feathers.core.FeathersControl;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.events.Event;
	import flash.geom.Rectangle;

	import ru.catAndBall.AppProperties;

	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.dict.tools.ToolDict;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.GridLayoutContainer;
	import ru.catAndBall.view.core.game.ResourceCounter;
	import ru.catAndBall.view.core.game.ResourceImage;
	import ru.catAndBall.view.core.text.BaseTextField;
	import ru.catAndBall.view.core.ui.MediumGreenButton;
	import ru.catAndBall.view.core.ui.SmallGreenButton;
	import ru.catAndBall.view.core.utils.L;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Image;

	import starling.events.Event;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                12.10.14 19:05
	 */
	public class CraftItem extends DefaultListItemRenderer {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_MAKE_CLICK:String = 'makeClick';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function CraftItem() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _title:BaseTextField;

		private var _description:BaseTextField;

		private var _icon:ResourceImage;

		private var _counter:BaseTextField;

		private var _resContainer:GridLayoutContainer;

		private var _toolData:ToolDict;

		private const _hashTypeToItem:Object = {};

		private var _dataInited:Boolean = false;

		private var _buttonMake:Button;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			_title = new BaseTextField(AssetList.font_large_white_shadow);
			_title.y = 60;
			addChild(_title);

			_description = new BaseTextField(AssetList.font_medium_white_shadow);
			_description.x = 195;
			_description.y = 165;
			_description.maxWidth = 350;
			_description.wordWrap = true;
			addChild(_description);

			_buttonMake = new MediumGreenButton(L.get('screen.craft.makeButton'));
			_buttonMake.addEventListener(starling.events.Event.TRIGGERED, handler_makeClick);
			addChild(_buttonMake);

			_counter = new BaseTextField(AssetList.font_small_white);
			addChild(_counter);

			_resContainer = new GridLayoutContainer(2, Layout.craft.priceIconSize, Layout.craft.priceIconSize, Layout.craft.priceIconGaps.x, Layout.craft.priceIconGaps.y);
			_resContainer.x = 970;
			_resContainer.y = _description.y;
			addChild(_resContainer);

			GameData.player.resources.addEventListener(flash.events.Event.CHANGE, handler_resourceChange);
		}

		protected override function draw():void {
			if (isInvalid(FeathersControl.INVALIDATION_FLAG_DATA)) {
				if (!_dataInited) {
					defaultSkin = Assets.getImage(index % 2 ? AssetList.Tools_toolsBg1 : AssetList.Tools_toolsBg2);

					_toolData = _data as ToolDict;

					var bgRect:Rectangle = new Rectangle(587, 132, 320, 320);

					_buttonMake.x = bgRect.x;
					_buttonMake.y = bgRect.y + bgRect.height + 10;
					_buttonMake.width = bgRect.width;

					_icon = new ResourceImage(_toolData.resourceType, Layout.craft.iconSize);
					_icon.x = bgRect.x + bgRect.width / 2 - Layout.craft.iconSize / 2;
					_icon.y = bgRect.y + bgRect.height / 2 - Layout.craft.iconSize / 2;
					addChild(_icon);

					_title.text = _toolData.name;
					_description.text = _toolData.description;

					for each (var type:String in ResourceSet.TYPES) {
						if (!_toolData.price.has(type)) continue;

						var item:ResourceCounter = new ResourceCounter(type, _toolData.price, Layout.craft.priceIconSize);
						item.maxResources = GameData.player.resources;
						_resContainer.addChild(item);
						_hashTypeToItem[type] = item;
					}

					_dataInited = true;
				}

				_title.validate();
				_title.x = AppProperties.baseWidth / 2 - _title.width / 2;

				_counter.text = String(GameData.player.resources.get(_toolData.resourceType));
				_counter.validate();
				_counter.x = 840;
				_counter.y = 380;

				setChildIndex(_counter, numChildren - 1);
			}

			super.draw();
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_resourceChange(event:*):void {
			invalidate(INVALIDATION_FLAG_DATA);
		}

		private function handler_makeClick(event:*):void {
			dispatchEventWith(EVENT_MAKE_CLICK, true, _toolData);
		}
	}
}
