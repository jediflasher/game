//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.controller.screen {

	import feathers.controls.ScreenNavigator;

	import ru.catAndBall.controller.generators.BaseGridGenerator;
	import ru.catAndBall.controller.tools.ToolCollectCells;
	import ru.catAndBall.data.GameData;
	import ru.catAndBall.data.game.GridFieldSettings;
	import ru.catAndBall.data.game.ResourceSet;
	import ru.catAndBall.data.game.field.GridCellType;
	import ru.catAndBall.data.game.tools.ToolCollectCellsData;
	import ru.catAndBall.view.core.game.FieldFooterBar;
	import ru.catAndBall.view.core.game.field.BaseScreenField;

	import starling.events.Event;

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

		private var _toolCollect:ToolCollectCells;

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		protected override function added():void {
			super.added();

			var toolData:ToolCollectCellsData = new ToolCollectCellsData(new <int>[
				GridCellType.TOY_BLUE,
				GridCellType.TOY_GREEN,
				GridCellType.TOY_RED,
				GridCellType.TOY_PURPLE
			], ResourceSet.TOOL_SPOKES, GameData.player.resources);

			_toolCollect = new ToolCollectCells(toolData);

			view.addEventListener(FieldFooterBar.EVENT_TOOLS_CLICK, handler_toolsClick);
		}

		protected override function removed():void {
			super.removed();

			view.addEventListener(FieldFooterBar.EVENT_TOOLS_CLICK, handler_toolsClick);
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

		private function handler_toolsClick(event:Event):void {
			_toolCollect.apply(_fieldData, _view.fieldController, _settings);
		}
	}
}
