////////////////////////////////////////////////////////////////////////////////
//
//  © 2015 CrazyPanda LLC
//
////////////////////////////////////////////////////////////////////////////////
package airlib.fla_parser {

	import ru.airlib.fla_parser.view.ParserFeathersButton;
	import ru.airlib.fla_parser.view.ParserFeathersDummy;
	import ru.airlib.fla_parser.view.ParserFeathersHint;
	import ru.airlib.fla_parser.view.ParserFeathersImage;
	import ru.airlib.fla_parser.view.ParserFeathersMovieClip;
	import ru.airlib.fla_parser.view.ParserFeathersScale9Image;
	import ru.airlib.fla_parser.view.ParserFeathersTextField;
	import ru.airlib.fla_parser.view.ParserFeathersTextInput;
	import ru.swfReader.descriptors.DisplayObjectDescriptor;
	import ru.swfReader.descriptors.TextFieldDescriptor;

	import starling.display.DisplayObject;

	/**
	 * @author                    Obi
	 * @langversion                3.0
	 * @date                    22.05.2015
	 */
	public class ObjectBuilder {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const _MAP:Object = {};

		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------

		public static function registerDependency(linkage:String, dependentClass:Class):void {
			_MAP[linkage] = dependentClass;
		}

		/*public static function buildFlash(flashChild:flash.display.DisplayObject, customFactory:Dictionary = null):DisplayObject {
		 var starlingChild:DisplayObject;

		 var cl:Class = (flashChild as Object).constructor as Class;
		 var className:String = getQualifiedClassName(flashChild is Bitmap ? (flashChild as Bitmap).bitmapData : flashChild);

		 var targetFactory:Dictionary;
		 if (cl) {
		 if (customFactory && cl in customFactory) targetFactory = customFactory;
		 else if (cl in _MAP) targetFactory = _MAP;
		 }

		 if (targetFactory) {
		 starlingChild = new (targetFactory[cl] as Class)(flashChild);
		 } else {
		 if (flashChild is TextField) {
		 var tf:TextField = flashChild as TextField;
		 starlingChild = tf.type == TextFieldType.INPUT ? new textInputRenderer(tf) : new textFieldRenderer(tf);
		 if (starlingChild is ParserFeathersTextField) {
		 (starlingChild as ParserFeathersTextField).text = tf.text;
		 } else {
		 (starlingChild as ParserFeathersTextInput).prompt = tf.text;
		 }
		 } else if (flashChild is Bitmap) {
		 starlingChild = new ParserFeathersImage(flashChild, className)
		 } else if (flashChild is Sprite) {
		 if (isTexture(className)) {
		 if (flashChild.scale9Grid) {
		 starlingChild = new ParserFeathersScale9Image(flashChild as Sprite, className);
		 } else {
		 starlingChild = new ParserFeathersImage(flashChild as Sprite, className);
		 }
		 } else if (isButton(className)) {
		 starlingChild = new buttonRenderer(flashChild as MovieClip);
		 } else if (isHint(className)) {
		 starlingChild = new ParserFeathersHint(flashChild as Sprite, className);
		 } else if (isDummy(className)) {
		 starlingChild = new ParserFeathersDummy(flashChild);
		 } else {
		 starlingChild = new ParserFeathersMovieClip(flashChild as MovieClip);
		 }
		 } else {
		 trace('Unknown display object: ', flashChild, className);
		 }
		 }

		 return starlingChild;
		 }*/

		public static function build(descriptor:DisplayObjectDescriptor, customFactory:Object = null):DisplayObject {
			var result:DisplayObject;
			var linkage:String = descriptor.linkage ? descriptor.linkage.name : null;

			var targetFactory:Object;
			if (linkage) {
				if (customFactory && (linkage in customFactory || descriptor.name in customFactory)) targetFactory = customFactory;
				else if (linkage in _MAP) targetFactory = _MAP;
			}

			if (targetFactory) {
				result = new (targetFactory[linkage] as Class)(descriptor);
			} else {
				if (descriptor is TextFieldDescriptor) {
					var td:TextFieldDescriptor = (descriptor as TextFieldDescriptor);
					result = td.editable ? new ParserFeathersTextInput(td) : new ParserFeathersTextField(td);
				} else if (isTexture(linkage)) {
					if (descriptor.linkage.scale9Grid) {
						result = new ParserFeathersScale9Image(descriptor);
					} else {
						result = new ParserFeathersImage(descriptor);
					}

				} else if (isButton(linkage)) {
					result = new buttonRenderer(descriptor);
				} else if (isHint(linkage)) {
					result = new ParserFeathersHint(descriptor);
				} else if (isDummy(linkage)) {
					result = new ParserFeathersDummy(descriptor);
				} else {
					result = new ParserFeathersMovieClip(descriptor);
				}
			}

			if (descriptor.name) result.name = descriptor.name;

			return result;
		}

		public static function isTexture(name:String):Boolean {
			return name.indexOf('tx_') > -1;
		}

		public static function normalize(name:String):String {
			return name.replace(/tx_|anim_/g, '');
		}

		public static function isButton(name:String):Boolean {
			return name.indexOf('button_') == 0;
		}

		public static function isSlider(name:String):Boolean {
			return name.indexOf('slider_') == 0;
		}

		public static function isHint(name:String):Boolean {
			return name.indexOf('hint_') == 0;
		}

		public static function isDummy(name:String):Boolean {
			return name == 'dummy';
		}

		/*
		 public static function setChildProperties(flash:flash.display.DisplayObject, starling:DisplayObject):void {
		 if (flash.name) {
		 starling.name = flash.name;
		 }

		 if (starling is ParserFeathersImage) {
		 var px:Number = starling.pivotX;
		 var py:Number = starling.pivotY;
		 starling.transformationMatrix = flash.transform.matrix;
		 starling.pivotX = px;
		 starling.pivotY = py;
		 starling.x = t(flash.x);
		 starling.y = t(flash.y);
		 } else {
		 starling.x = t(flash.x);
		 starling.y = t(flash.y);

		 if (starling is Scale9Image || starling is LayoutGroup) {
		 starling.width = t(flash.width);
		 starling.height = t(flash.height);
		 } else {
		 if (flash.width > 0) {
		 starling.width = t(flash.width) / flash.scaleX;
		 }

		 if (flash.height > 0) {
		 starling.height = t(flash.height) / flash.scaleY;
		 }

		 var matrix:Matrix = flash.transform.matrix;
		 var skewX:Number = Math.atan(-matrix.c / matrix.d);
		 var skewY:Number = Math.atan( matrix.b / matrix.a);

		 // NaN check ("isNaN" causes allocation)
		 if (skewX != skewX) skewX = 0.0;
		 if (skewY != skewY) skewY = 0.0;

		 const PI_Q:Number = Math.PI / 4;
		 starling.scaleX = (skewX > -PI_Q && skewX < PI_Q) ?  matrix.d / Math.cos(skewX)
		 : -matrix.c / Math.sin(skewX);
		 starling.scaleY = (skewY > -PI_Q && skewY < PI_Q) ?  matrix.a / Math.cos(skewY)
		 :  matrix.b / Math.sin(skewY);

		 starling.skewX = skewX;
		 starling.skewY = skewY;
		 }

		 starling.rotation = flash.rotation / 180 * Math.PI;

		 /*if (!(starling is LayoutGroup)) {
		 starling.x = t(flash.x);
		 starling.y = t(flash.y);
		 starling.width = t(flash.width);
		 starling.height = t(flash.height);
		 starling.rotation = flash.rotation / 180 * Math.PI;
		 }*/
//			}

//			starling.alpha = flash.alpha;
//		}

		/*	public static function setFlashChildProperties(flash:flash.display.DisplayObject, starling:DisplayObject):void {
		 if (flash.name) {
		 starling.name = flash.name;
		 }

		 if (starling is ParserFeathersImage) {
		 var px:Number = starling.pivotX;
		 var py:Number = starling.pivotY;
		 starling.transformationMatrix = flash.transform.matrix;
		 starling.pivotX = px;
		 starling.pivotY = py;
		 starling.x = t(flash.x);
		 starling.y = t(flash.y);

		 //				var color:uint = 0xFFFFFF;
		 //				(starling as ParserFeathersImage).color = flash.transform.colorTransform
		 } else {
		 starling.x = t(flash.x);
		 starling.y = t(flash.y);

		 if (starling is Scale9Image || starling is ParserFeathersDummy) {
		 starling.width = t(flash.width);
		 starling.height = t(flash.height);
		 starling.rotation = flash.rotation / 180 * Math.PI;
		 } else if (!(starling is LayoutGroup)) {
		 if (flash.width > 0) starling.width = t(flash.width) / flash.scaleX;
		 if (flash.height > 0) starling.height = t(flash.height) / flash.scaleY;

		 starling.scaleX = flash.scaleX;
		 starling.scaleY = flash.scaleY;

		 var matrix:Matrix = flash.transform.matrix;
		 var skewX:Number = Math.atan(-matrix.c / matrix.d);
		 var skewY:Number = Math.atan(matrix.b / matrix.a);

		 // NaN check ("isNaN" causes allocation)
		 if (skewX != skewX) skewX = 0.0;
		 if (skewY != skewY) skewY = 0.0;

		 const PI_Q:Number = Math.PI / 4;
		 starling.scaleX = (skewX > -PI_Q && skewX < PI_Q) ? matrix.d / Math.cos(skewX)
		 : -matrix.c / Math.sin(skewX);
		 starling.scaleY = (skewY > -PI_Q && skewY < PI_Q) ? matrix.a / Math.cos(skewY)
		 : matrix.b / Math.sin(skewY);

		 //					starling.skewX = skewX;
		 //					starling.skewY = skewY;

		 starling.rotation = flash.rotation / 180 * Math.PI;
		 }
		 }

		 starling.alpha = flash.alpha;
		 }

		 public static function setChildPropertiesForAnimation(flash:flash.display.DisplayObject, starling:DisplayObject):void {
		 setFlashChildProperties(flash, starling);
		 return;

		 if (flash.name) {
		 starling.name = flash.name;
		 }

		 if (starling is ParserFeathersImage) {
		 starling.transformationMatrix = flash.transform.matrix;
		 starling.x = t(flash.x);
		 starling.y = t(flash.y);
		 } else {
		 if (!(starling is LayoutGroup)) {
		 starling.x = t(flash.x);
		 starling.y = t(flash.y);
		 starling.width = t(flash.width);
		 starling.height = t(flash.height);
		 starling.rotation = flash.rotation / 180 * Math.PI;
		 }
		 }

		 starling.alpha = flash.alpha;
		 }
		 */
		//--------------------------------------------------------------------------
		//
		//  Class properties
		//
		//--------------------------------------------------------------------------

		public static var buttonRenderer:Class = ParserFeathersButton;

		public static var textInputRenderer:Class = ParserFeathersTextInput;

		public static var textFieldRenderer:Class = ParserFeathersTextField;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ObjectBuilder() {
			super();
		}
	}
}
