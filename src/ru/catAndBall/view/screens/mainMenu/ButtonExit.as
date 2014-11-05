//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.mainMenu {

	import ru.catAndBall.view.core.ui.BaseButton;
	import ru.catAndBall.view.core.text.TextFieldMedium;

	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                09.06.14 23:40
	 */
	public class ButtonExit extends BaseButton {

		private static const BG_UP:String = 'buttonGray';

		private static const BG_DOWN:String = 'buttonGrayDown';

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ButtonExit() {
			super(BG_UP, BG_DOWN);

			var tf:TextFieldMedium = new TextFieldMedium('Выход');
			tf.width = width;
			tf.height = height;
			tf.hAlign = HAlign.CENTER;
			tf.vAlign = VAlign.CENTER;
			addChild(tf);
		}
	}
}
