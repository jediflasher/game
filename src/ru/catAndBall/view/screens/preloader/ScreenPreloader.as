//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.preloader {

	import flash.display.Loader;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.core.ui.LoaderBar;
	import ru.catAndBall.view.core.utils.Line;
	import ru.catAndBall.view.screens.BaseScreen;

	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                26.06.14 20:42
	 */
	public class ScreenPreloader extends BaseScreen {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenPreloader(data:BaseScreenData = null) {
			super(data);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _line:LoaderBar;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get progress():Number {
			return _line.progress;
		}

		public function set progress(value:Number):void {
			_line.progress = value;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function initialize():void {
			_line = new LoaderBar(200);
			addChild(_line);
		}

		protected override function draw():void {
			super.draw();

			_line.x = AppProperties.appWidth / 2 - _line.width / 2;
			_line.y = AppProperties.appHeight * 0.7;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

	}
}
