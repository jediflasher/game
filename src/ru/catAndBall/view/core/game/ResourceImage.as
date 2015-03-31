package ru.catAndBall.view.core.game {
	import flash.display.BitmapData;

	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.layout.Layout;

	import starling.display.Image;
	import starling.textures.Texture;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                28.10.14 8:41
	 */
	public class ResourceImage extends Image {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const DUMMY:Texture = Texture.fromBitmapData(new BitmapData(100, 100, false, 0xFF0000));

		private static const HASH:Object = {};

		HASH[ResourceSet.MONEY] = [
			AssetList.header_catmoneyIcon,
			AssetList.header_catmoneyIcon,
			AssetList.header_catmoneyIcon
		];
		HASH[ResourceSet.EXPERIENCE] = [
			AssetList.header_header_icon_exp,
			AssetList.header_header_icon_exp,
			AssetList.header_header_icon_exp
		];
		HASH[ResourceSet.MOUSE] = [
			AssetList.header_header_mouseIcon,
			AssetList.header_header_mouseIcon,
			AssetList.header_header_mouseIcon
		];
		HASH[ResourceSet.BF_BALLS] = [
			AssetList.fields_balls_component_ballIcon,
			AssetList.fields_balls_component_ballIconDisabled,
			AssetList.inventory_grey_icon_ballIconGrey
		];
		HASH[ResourceSet.BF_SOCKS] = [
			AssetList.fields_balls_component_socksIcon,
			AssetList.fields_balls_component_socksIconDisabled,
			AssetList.inventory_grey_icon_socksIconGrey
		];
		HASH[ResourceSet.BF_SWEATERS] = [
			AssetList.fields_balls_component_sweaterIcon,
			AssetList.fields_balls_component_sweaterIconDisabled,
			AssetList.inventory_grey_icon_sweaterIconGrey
		];
		HASH[ResourceSet.BF_TOYS] = [
			AssetList.fields_balls_component_toyIcon,
			AssetList.fields_balls_component_toyIconDisabled,
			AssetList.inventory_grey_icon_toyIconGrey
		];
		HASH[ResourceSet.RF_BALL] = [
			AssetList.fields_carpet_components_globIcon,
			AssetList.fields_carpet_components_globIconDisabled,
			AssetList.inventory_grey_icon_globIconGrey
		];
		HASH[ResourceSet.RF_CONSERVE] = [
			AssetList.fields_carpet_components_cannedIcon,
			AssetList.fields_carpet_components_cannedIconDisabled,
			AssetList.inventory_grey_icon_cannedIconGrey
		];
		HASH[ResourceSet.RF_COOKIE] = [
			AssetList.fields_carpet_components_cookieIcon,
			AssetList.fields_carpet_components_cookieIconDisabled,
			AssetList.inventory_grey_icon_cookieIconGrey
		];
		HASH[ResourceSet.RF_MOUSE] = [
			AssetList.header_header_mouseIcon,
			AssetList.fields_carpet_components_mouseIconDisabled,
			AssetList.inventory_grey_icon_mouseIconGrey
		];
		HASH[ResourceSet.RF_PIGEON] = [
			AssetList.fields_carpet_components_doveIcon,
			AssetList.fields_carpet_components_doveIconDisabled,
			AssetList.inventory_grey_icon_doveIconGrey
		];
		HASH[ResourceSet.RF_MILK] = [
			AssetList.fields_carpet_components_milkIcon,
			AssetList.fields_carpet_components_milkIconDisabled,
			AssetList.inventory_grey_icon_milkIconGrey
		];
		HASH[ResourceSet.RF_THREAD] = [
			AssetList.fields_carpet_components_threadsIcon,
			AssetList.fields_carpet_components_threadsIconDisabled,
			AssetList.inventory_grey_icon_threadsIconGrey
		];
		HASH[ResourceSet.RF_GRAIN] = [
			AssetList.fields_carpet_components_grainIcon,
			AssetList.fields_carpet_components_grainIconDisabled,
			AssetList.inventory_grey_icon_grainIconGrey
		];

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ResourceImage(resourceSetType:String, size:int = 0) {
			_resourceType = resourceSetType;
			super(getTexture());
			width = size || Layout.baseResourceIconSize;
			height = size || Layout.baseResourceIconSize;
			touchable = false;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _disabled:Boolean = false;

		public function get disabled():Boolean {
			return _disabled;
		}

		public function set disabled(value:Boolean):void {
			if (_disabled == value) return;

			_disabled = value;
			texture = getTexture();
		}


		private var _gray:Boolean = false;

		public function get gray():Boolean {
			return _gray;
		}

		public function set gray(value:Boolean):void {
			if (_gray == value) return;

			_gray = value;
			texture = getTexture();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _resourceType:String;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		private function getTexture():Texture {
			if (!(_resourceType in HASH)) {

				if(_resourceType.indexOf('tool_') == 0) {
					return Assets.getTexture('panel_tools/tools_icon/' + _resourceType) || DUMMY;
				}

				return DUMMY;
			}

			var index:int = 0;
			if (_gray) {
				index = 2;
			} else if (_disabled) {
				index = 1;
			} else {
				index = 0;
			}

			return Assets.getTexture(HASH[_resourceType][index]);
		}
	}
}
