////////////////////////////////////////////////////////////////////////////////
//
//  © 2015 CrazyPanda LLC
//
////////////////////////////////////////////////////////////////////////////////
package airlib.fla_parser.view {

	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;

	import ru.airlib.fla_parser.ObjectBuilder;
	import ru.airlib.util.Assets;
	import ru.airlib.util.t;
	import ru.swfReader.descriptors.DisplayObjectDescriptor;

	import starling.textures.Texture;

	/**
	 * @author                    Obi
	 * @langversion                3.0
	 * @date                    27.05.2015
	 */
	public class ParserFeathersScale9Image extends Scale9Image {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ParserFeathersScale9Image(source:DisplayObjectDescriptor) {
			var rect:Rectangle = source.linkage.scale9Grid.clone();
			rect.setTo(t(rect.x), t(rect.y), t(rect.width), t(rect.height));
			var texture:Texture = Assets.getTexture(ObjectBuilder.normalize(source.linkage.name));
			var textures:Scale9Textures = new Scale9Textures(texture, rect);
			super(textures);

			var frameBounds:Rectangle = source.getFrameBounds();
			pivotX = t(-frameBounds.x);
			pivotY = t(-frameBounds.y);
		}

		public function get rect():Rectangle {
			return super.textures.scale9Grid;
		}
	}
}
