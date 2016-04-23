//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.mainMenu {
	
	import airlib.util.localization.loc;
	import airlib.view.core.BaseParserScreen;

	import ru.catAndBall.view.screens.ScreenType;
	import ru.flaswf.parsers.feathers.view.ParserFeathersButton;

	import starling.events.Event;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                07.06.14 19:14
	 */
	public class ScreenMenu extends BaseParserScreen {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_GAME_CLICK:String = 'continueClick';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScreenMenu() {
			super(ScreenType.MAIN_MENU, Library.get('ScreenMainMenu'));
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		public var _startBtn:ParserFeathersButton;

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			super.initialize();
			autoAssign();

			_startBtn.label = loc('screen.menu.start_button.label');
			bindEvent(_startBtn, Event.TRIGGERED, EVENT_GAME_CLICK);
		}
	}
}
