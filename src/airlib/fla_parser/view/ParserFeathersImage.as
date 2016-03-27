////////////////////////////////////////////////////////////////////////////////
//
//  © 2015 CrazyPanda LLC
//
////////////////////////////////////////////////////////////////////////////////
package airlib.fla_parser.view {

	import flash.geom.Rectangle;

	import ru.airlib.fla_parser.ObjectBuilder;
	import ru.airlib.util.Assets;
	import ru.airlib.util.t;
	import ru.swfReader.descriptors.DisplayObjectDescriptor;

	import starling.display.Image;

	/**
	 * @author                    Obi
	 * @langversion                3.0
	 * @date                    22.05.2015
	 */
	public class ParserFeathersImage extends Image {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ParserFeathersImage(source:DisplayObjectDescriptor, textureName:String = null) {
			super(Assets.getTexture(ObjectBuilder.normalize(textureName || source.linkage.name)));
			this.source = source;

			var frameBounds:Rectangle = source.linkage.frames[0].bounds;
			pivotX = t(-frameBounds.x);
			pivotY = t(-frameBounds.y);
		}

		public var source:DisplayObjectDescriptor;
	}
}
