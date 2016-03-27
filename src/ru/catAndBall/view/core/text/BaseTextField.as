//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.text {
	
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.text.BitmapFontTextFormat;
	
	import flash.text.TextFormatAlign;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                16.08.14 22:40
	 */
	public class BaseTextField extends BitmapFontTextRenderer {

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

		public function BaseTextField(fontId:String, align:String = TextFormatAlign.LEFT) {
			super();
			super.textFormat = new BitmapFontTextFormat(fontId, NaN, 0xffffff, align);
		}

	}
}
