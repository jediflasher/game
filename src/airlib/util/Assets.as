package airlib.util {

	import airlib.util.log.error;

	import feathers.controls.Button;

	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	import ru.airlib.util.log.error;

	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                15.06.14 15:14
	 */
	public class Assets {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const FONT_SMALL:String = 'fontSmall';

		public static const FONT_MEDIUM:String = 'fontMedium';

		public static const FONT_LARGE:String = 'fontLarge';

		public static var DUMMY_TEXTURE:Texture;

		public static var DUMMY_TEXTURE_2:Texture;

		public static var OVERLAY:Texture;

		private static const PREFIX:String = 'Images/';

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		private static var _assetManager:AssetManager;

		private static var _hash:Object = {}; // name -> texture/null

		public static var scaleFactor:Number = 1;

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function init(assetManager:AssetManager, scaleFactor:Number):void {
			_assetManager = assetManager;
			_assetManager.scaleFactor = scaleFactor;
			_assetManager.useMipMaps = false;
		}

		public static function initComplete():void {
			DUMMY_TEXTURE = Texture.fromBitmapData(new BitmapData(30, 30, false, 0xFFFF0000));
			DUMMY_TEXTURE_2 = Texture.fromBitmapData(new BitmapData(30, 30, false, 0xFF00FF00));
			OVERLAY = Texture.fromBitmapData(new BitmapData(10, 10, true, 0x66000000));
		}

		/**
		 * Scales base value to current scale factor
		 * @param baseValue
		 * @return scaled value
		 */
		public static function s(baseValue:Number):Number {
			return baseValue * scaleFactor;
		}

		public static function getTexture(name:String):Texture {
			if (!(name in _hash)) {
				_hash[name] = _assetManager.getTexture(name);
			}

			var result:Texture = _hash[name];
			if (!result) {
				error('Assets.getTexture', 'Can not find texture {0}', [name]);
				result = DUMMY_TEXTURE;
			}

			return result;
		}

		public static function hasTexture(name:String):Boolean {
			return getTexture(name) != null;
		}

		public static function getImage(name:String, width:Number = NaN, height:Number = NaN):Image {
			var txt:Texture = getTexture(name);
			if (!txt) return null;
			var result:Image = new Image(txt);
			if (width == width) result.width = width;
			if (height == height) result.height = height;
			return result;
		}

		public static function getTextures(prefix:String):Vector.<Texture> {
			if (!(prefix in _hash)) {
				_hash[prefix] = _assetManager.getTextures(prefix);
			}

			return _hash[prefix];
		}

		public static function getButton(prefix:String):Button {
			var up:Image = getImage(prefix);
			var down:Image = getImage(prefix + '_on');
			var disabled:Image = getImage(prefix + '_off');
			var result:Button = new Button();
			result.defaultSkin = up;
			result.downSkin = down;
			result.disabledSkin = disabled;
			return result;
		}

		public static function getXml(name:String):XML {
			return _assetManager.getXml(name);
		}

		public static function getAtlas(name:String):TextureAtlas {
			return _assetManager.getTextureAtlas(name);
		}

		public static function getByteArray(name:String):ByteArray {
			return _assetManager.getByteArray(name);
		}

		public static function getJSON(name:String):Object {
			return _assetManager.getObject(name);
		}
	}
}
