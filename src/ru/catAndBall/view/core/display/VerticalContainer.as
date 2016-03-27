package ru.catAndBall.view.core.display {
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.10.14 10:53
	 */
	public class VerticalContainer extends LayoutGroup {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function VerticalContainer() {
			super();
			super.layout = new VerticalLayout();
		}
	}
}
