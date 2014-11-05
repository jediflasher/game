package ru.catAndBall.view.core.game {
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;

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
			AssetList.header_catmoneyIcon
		];
		HASH[ResourceSet.EXPERIENCE] = [
			AssetList.header_header_icon_lexp,
			AssetList.header_header_icon_lexp
		];
		HASH[ResourceSet.BF_BALLS] = [
			AssetList.fields_balls_component_screenFieldBalls_ballsIcon,
			AssetList.fields_balls_component_screenFieldBalls_ballsIconDisabled
		];
		HASH[ResourceSet.BF_SOCKS] = [
			AssetList.fields_balls_component_screenFieldBalls_socksIcon,
			AssetList.fields_balls_component_screenFieldBalls_socksIconDisabled
		];
		HASH[ResourceSet.BF_SWEATERS] = [
			AssetList.fields_balls_component_screenFieldBalls_sweaterIcon,
			AssetList.fields_balls_component_screenFieldBalls_sweaterIconDisabled
		];
		HASH[ResourceSet.BF_TOYS] = [
			AssetList.fields_balls_component_screenFieldBalls_toysIcon,
			AssetList.fields_balls_component_screenFieldBalls_toysIconDisabled
		];
		HASH[ResourceSet.RF_BALL] = [
			AssetList.fields_carpet_components_screenFieldCarpet_ballIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_ballIconDisabled
		];
		HASH[ResourceSet.RF_CONSERVE] = [
			AssetList.fields_carpet_components_screenFieldCarpet_cannedIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_cannedIconDisabled
		];
		HASH[ResourceSet.RF_COOKIE] = [
			AssetList.fields_carpet_components_screenFieldCarpet_cookieIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_cookieIconDisabled
		];
		HASH[ResourceSet.RF_MOUSE] = [
			AssetList.fields_carpet_components_screenFieldCarpet_mouseIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_mouseIconDisabled
		];
		HASH[ResourceSet.RF_PIGEON] = [
			AssetList.fields_carpet_components_screenFieldCarpet_doveIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_doveIcon_Disabled
		];
		HASH[ResourceSet.RF_SAUSAGE] = [
			AssetList.fields_carpet_components_screenFieldCarpet_sausageIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_sausageIconDisabled
		];
		HASH[ResourceSet.RF_THREAD] = [
			AssetList.fields_carpet_components_screenFieldCarpet_threadIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_threadIconDisabled
		];
		HASH[ResourceSet.RF_WRAPPER] = [
			AssetList.fields_carpet_components_screenFieldCarpet_wrapperIcon,
			AssetList.fields_carpet_components_screenFieldCarpet_wrapperIconDisabled
		];

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ResourceImage(resourseSetType:String) {
			_resourceType = resourseSetType;
			super(getTexture());
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
			return Assets.getTexture(HASH[_resourceType][_disabled ? 1 : 0]);
		}
	}
}
