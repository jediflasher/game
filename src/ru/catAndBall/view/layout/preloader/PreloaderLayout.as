package ru.catAndBall.view.layout.preloader {
	
	import ru.catAndBall.AppProperties;
	
	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                03.11.14 18:11
	 */
	public class PreloaderLayout {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function PreloaderLayout() {
			super();
		}

		public var logoY:Number = AppProperties.getValue(800, 500);

		public var buttonY:Number = AppProperties.getValue(1000, 650);

		public var progressBarRegions:Array = AppProperties.getValue([30, 11], [20, 6]);
	}
}
