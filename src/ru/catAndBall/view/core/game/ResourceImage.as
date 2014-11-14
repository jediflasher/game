package ru.catAndBall.view.core.game {
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

		private static const HASH:Object = {};

		HASH[ResourceSet.MONEY] = [
			AssetList.header_catmoneyIcon,
			AssetList.header_catmoneyIcon,
			AssetList.header_catmoneyIcon
		];
		HASH[ResourceSet.EXPERIENCE] = [
			AssetList.header_header_icon_lexp,
			AssetList.header_header_icon_lexp,
			AssetList.header_header_icon_lexp
		];
		HASH[ResourceSet.TOOL_BOWL] = [
			AssetList.panel_tools_kontener,
			AssetList.panel_tools_kontener,
			AssetList.inventory_grey_icon_konteiner_shadow
		];
		HASH[ResourceSet.TOOL_BROOM] = [
			AssetList.panel_tools_venik,
			AssetList.panel_tools_venik,
			AssetList.inventory_grey_icon_venik_shadow
		];
		HASH[ResourceSet.TOOL_SPOKES] = [
			AssetList.panel_tools_spitsbl,
			AssetList.panel_tools_spitsbl,
			AssetList.inventory_grey_icon_spitsbl_shadow
		];
		HASH[ResourceSet.TOOL_SPOOL] = [
			AssetList.panel_tools_katyshka,
			AssetList.panel_tools_katyshka,
			AssetList.inventory_grey_icon_katushka_shadow
		];
		HASH[ResourceSet.TOOL_TEA] = [
			AssetList.panel_tools_coffee,
			AssetList.panel_tools_coffee,
			AssetList.inventory_grey_icon_coffe_shadow
		];
		HASH[ResourceSet.TOOL_TOY_BOX] = [
			AssetList.panel_tools_korobka,
			AssetList.panel_tools_korobka,
			AssetList.inventory_grey_icon_box_shadow
		];
		HASH[ResourceSet.BF_BALLS] = [
			AssetList.fields_balls_component_screenFieldBalls_ballsIcon,
			AssetList.fields_balls_component_screenFieldBalls_ballsIconDisabled,
			AssetList.inventory_grey_icon_balls_shadow
		];
		HASH[ResourceSet.BF_SOCKS] = [
			AssetList.fields_balls_component_screenFieldBalls_socksIcon,
			AssetList.fields_balls_component_screenFieldBalls_socksIconDisabled,
			AssetList.inventory_grey_icon_socks_shadow
		];
		HASH[ResourceSet.BF_SWEATERS] = [
			AssetList.fields_balls_component_screenFieldBalls_sweaterIcon,
			AssetList.fields_balls_component_screenFieldBalls_sweaterIconDisabled,
			AssetList.inventory_grey_icon_sweaters_shadow
		];
		HASH[ResourceSet.BF_TOYS] = [
			AssetList.fields_balls_component_screenFieldBalls_toysIcon,
			AssetList.fields_balls_component_screenFieldBalls_toysIconDisabled,
			AssetList.inventory_grey_icon_toys_shadow
		];
		HASH[ResourceSet.RF_BALL] = [
			AssetList.fields_carpet_components_screenFieldCarpet_ballIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_ballIconDisabled,
			AssetList.inventory_grey_icon_balls_shadow
		];
		HASH[ResourceSet.RF_CONSERVE] = [
			AssetList.fields_carpet_components_screenFieldCarpet_cannedIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_cannedIconDisabled,
			AssetList.inventory_grey_icon_konservbl_shadow
		];
		HASH[ResourceSet.RF_COOKIE] = [
			AssetList.fields_carpet_components_screenFieldCarpet_cookieIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_cookieIconDisabled,
			AssetList.inventory_grey_icon_cookies_shadow
		];
		HASH[ResourceSet.RF_MOUSE] = [
			AssetList.fields_carpet_components_screenFieldCarpet_mouseIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_mouseIconDisabled,
			AssetList.inventory_grey_icon_mouse_shadow
		];
		HASH[ResourceSet.RF_PIGEON] = [
			AssetList.fields_carpet_components_screenFieldCarpet_doveIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_doveIcon_Disabled,
			AssetList.inventory_grey_icon_dove_shadow
		];
		HASH[ResourceSet.RF_MILK] = [
			AssetList.fields_carpet_components_screenFieldCarpet_sausageIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_sausageIconDisabled,
			AssetList.inventory_grey_icon_kolbasa_shadow
		];
		HASH[ResourceSet.RF_THREAD] = [
			AssetList.fields_carpet_components_screenFieldCarpet_threadIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_threadIconDisabled,
			AssetList.inventory_grey_icon_nitki_shadow
		];
		HASH[ResourceSet.RF_WRAPPER] = [
			AssetList.fields_carpet_components_screenFieldCarpet_wrapperIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_wrapperIconDisabled,
			AssetList.inventory_grey_icon_wrappers_shadow
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
				HASH[_resourceType] = [
					AssetList.fields_balls_component_screenFieldBalls_socksIcon,
					AssetList.fields_balls_component_screenFieldBalls_socksIconDisabled,
					AssetList.inventory_grey_icon_socks_shadow
				];
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
