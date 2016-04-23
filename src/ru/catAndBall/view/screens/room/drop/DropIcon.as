package ru.catAndBall.view.screens.room.drop {
	
	import com.greensock.TweenNano;
	
	import flash.errors.IllegalOperationError;
	
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
	 * @date                04.10.14 18:39
	 */
	public class DropIcon extends Image {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const POOL:Vector.<DropIcon> = new Vector.<DropIcon>();

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function fromPool(resourceType:String, count:int):DropIcon {
			if (!POOL.length) {
				var icon:DropIcon = new DropIcon(resourceType, count, new Privater());
				POOL.push(icon);
			}

			var result:DropIcon = POOL.pop();
			result.count = count;
			result.resourceType = resourceType;
			return result;
		}

		public static function toPool(value:DropIcon):void {
			value.touchable = true;
			value.count = 0;
			value.removeEventListeners();
			value.alpha = 1;
			if (value.parent) value.parent.removeChild(value);
			TweenNano.killTweensOf(value);
			POOL.push(value);
		}

		private static function fromType(type:String):Texture {
			switch (type) {
				case ResourceSet.EXPERIENCE:
					return Assets.getTexture('header_lvlIcon');
				default:
					return Math.random() > 0.5 ? Assets.DUMMY_TEXTURE_2 : Assets.DUMMY_TEXTURE;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function DropIcon(resourceType:String, count:int, p:Privater) {
			super(fromType(resourceType));
			if (!p) throw new IllegalOperationError('Use DropIcon.fromPool()');

			this.count = count;
			this._resourceType = resourceType;
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var count:int;

		private var _resourceType:String;

		public function get resourceType():String {
			return _resourceType;
		}

		public function set resourceType(value:String):void {
			if (_resourceType == value) return;

			_resourceType = value;
			this.texture = fromType(_resourceType)
		}
	}
}

final class Privater {}
