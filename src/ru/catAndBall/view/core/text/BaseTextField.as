//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.text {
	
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.text.BitmapFontTextFormat;

	import flash.filters.DropShadowFilter;

	import flash.text.TextFormat;
	
	import flash.text.TextFormatAlign;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                16.08.14 22:40
	 */
	public class BaseTextField extends TextFieldTextRenderer {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseTextField(color:uint, size:Number) {
			super();
			super.embedFonts = true;
			super.textFormat = new TextFormat('RotondaC Bold', size, color);
			super.nativeFilters = [new DropShadowFilter(1, 90)]
		}

	}
}
