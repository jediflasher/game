//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.screen {
	
	import feathers.controls.ScreenNavigator;
	
	import ru.catAndBall.controller.generators.BaseGridGenerator;
	import ru.catAndBall.controller.tools.BaseToolController;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.dict.Dictionaries;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.settings.GridFieldSettings;
	import ru.catAndBall.data.game.tools.BaseToolData;
	import ru.catAndBall.view.core.game.field.BaseScreenField;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 19:49
	 */
	public class ScreenBallsFieldController extends BaseScreenFieldController {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenBallsFieldController(navigator:ScreenNavigator, screen:BaseScreenField) {
			var settings:GridFieldSettings = screen.screenData.gridData.settings;
			var generator:BaseGridGenerator = new BaseGridGenerator(settings);

			super(navigator, screen, generator);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _toolCollect:BaseToolController;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		protected override function added():void {
			super.added();

			var toolData:BaseToolData = new BaseToolData(Dictionaries.tools.getToolByResourceType(ResourceSet.TOOL_BASKET), GameData.player.resources);
			_toolCollect = new BaseToolController(toolData);
		}

		protected override function removed():void {
			super.removed();
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

	}
}
