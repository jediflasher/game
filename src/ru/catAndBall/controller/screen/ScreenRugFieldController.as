//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.screen {
	
	import feathers.controls.ScreenNavigator;
	
	import ru.catAndBall.controller.generators.BaseGridGenerator;
	import ru.catAndBall.data.game.settings.GridFieldSettings;
	import ru.catAndBall.view.core.game.field.BaseScreenField;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                19.07.14 12:32
	 */
	public class ScreenRugFieldController extends BaseScreenFieldController {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenRugFieldController(navigator:ScreenNavigator, screen:BaseScreenField) {
			var settings:GridFieldSettings = screen.screenData.gridData.settings;
			var generator:BaseGridGenerator = new BaseGridGenerator(settings);

			super(navigator, screen, generator);
		}
	}
}
