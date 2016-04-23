package {

	import flash.text.Font;
	import flash.utils.ByteArray;

	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.screens.room.header.RoomHeaderExpPanel;
	import ru.catAndBall.view.screens.room.header.RoomHeader;
	
	import ru.flaswf.parsers.feathers.ObjectBuilder;
	
	import ru.flaswf.reader.descriptors.DisplayObjectDescriptor;
	import ru.flaswf.reader.descriptors.LinkageDescriptor;

	import ru.flaswf.reader.descriptors.SwfDescriptor;
	
	import starling.utils.AssetManager;
	
	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                27.03.2016 16:57
	 */
	public class Library {
		
		// fonts
		[Embed(source="../bin/assets/fonts/RotondaC-Bold.otf", fontName="RotondaC Bold", fontWeight="normal", mimeType="application/x-font", embedAsCFF='false')]
		public static var RotondaCBold:Class;

		private static var _swf:SwfDescriptor;

		private static var _linkCount:int;

		public static function init(swfBytes:ByteArray):void {
			Font.registerFont(RotondaCBold);

			trace('App fonts:');
			for each (var f:Font in Font.enumerateFonts()) {
				trace(f.fontName, f.fontStyle, f.fontType);
			}

			ObjectBuilder.getTexture = Assets.getTexture;
			_swf = new SwfDescriptor(swfBytes);
			
			ObjectBuilder.registerDependency('RoomHeader', RoomHeader);
			ObjectBuilder.registerDependency('RoomHeaderExpPanel', RoomHeaderExpPanel);
		}

		public static function get(linkage:String):DisplayObjectDescriptor {
			var link:LinkageDescriptor = _swf.getLinkageByName(linkage);
			var result:DisplayObjectDescriptor = new DisplayObjectDescriptor();
			result.linkage = link;
			result.linkToDescriptor = link.link;
			result.name = linkage + '#' + _linkCount++;
			return result;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Library() {
			super();
		}
	}
}
