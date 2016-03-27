////////////////////////////////////////////////////////////////////////////////
//
//  © 2015 CrazyPanda LLC
//
////////////////////////////////////////////////////////////////////////////////
package airlib.fla_parser.view {

	import feathers.controls.text.TextFieldTextRenderer;

	import flash.filters.BitmapFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	import ru.airlib.AppProperties;
	import ru.airlib.util.t;
	import ru.swfReader.descriptors.BitmapFilterDescriptor;
	import ru.swfReader.descriptors.TextFieldDescriptor;

	/**
	 * @author                    Obi
	 * @langversion                3.0
	 * @date                    22.05.2015
	 */
	public class ParserFeathersTextField extends TextFieldTextRenderer {

		private static const PROCESSED_TEXTFIELDS:Dictionary = new Dictionary(true);

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ParserFeathersTextField(source:TextFieldDescriptor) {
			super();

			var fmt:TextFormat = source.textFormat;
			var nativeFilters:Array;

			if (!(source in PROCESSED_TEXTFIELDS)) {
				var configFilters:Vector.<BitmapFilterDescriptor> = source.filters;
				if (configFilters) {

					nativeFilters = [];

					for each (var fd:BitmapFilterDescriptor in configFilters) {
						var f:BitmapFilter = BitmapFilterDescriptor.toNative(fd);

						if (f is GlowFilter) {
							(f as GlowFilter).blurX *= AppProperties.workspaceScale;
							(f as GlowFilter).blurY *= AppProperties.workspaceScale;
						}

						nativeFilters.push(f);
					}
				}

				fmt.blockIndent = int(t(fmt.blockIndent));
				fmt.indent = int(t(fmt.indent));
				fmt.leading = int(t(fmt.leading));
				fmt.leftMargin = int(t(fmt.leftMargin));
				fmt.letterSpacing = int(t(fmt.letterSpacing));
				fmt.rightMargin = int(t(fmt.rightMargin));
				fmt.size = int(t(fmt.size));

				PROCESSED_TEXTFIELDS[source] = true;
			}

			super.nativeFilters = nativeFilters;
			displayAsPassword = source.displayAsPassword;
			embedFonts = true;
			isHTML = true;
			textFormat = fmt;
			snapToPixels = true;
//			useSnapshotDelayWorkaround = true;

			super.wordWrap = source.multiline;
			super.width = t(source.width);
			super.height = t(source.height);

			super.text = source.text;
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------


		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function draw():void {
			super.draw();

			if (isInvalid()) {
				setSizeInternal(textField.textWidth, textField.textHeight + t(10), false);
			}
		}
	}
}
