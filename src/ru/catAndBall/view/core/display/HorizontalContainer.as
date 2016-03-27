package ru.catAndBall.view.core.display {
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.HorizontalLayout;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.10.14 20:16
	 */
	public class HorizontalContainer extends LayoutGroup {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function HorizontalContainer() {
			super();

			var l:HorizontalLayout = new HorizontalLayout();
			l.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;

			layout = l;
		}
	}
}
