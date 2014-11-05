//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.screens.windowField {

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.data.game.screens.BaseScreenData;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.game.field.BaseScreenField;
	import ru.catAndBall.view.core.ui.BaseButton;

	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                19.07.14 14:31
	 */
	public class ScreenWindowField extends BaseScreenField {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_BEERCUP_APPLY:String = 'eventBeercupApply';

		public static const EVENT_BUTTERFLY_APPLY:String = 'eventButterflyApply';

		public static const EVENT_LADYBUG_APPLY:String = 'eventLadybugApply';


		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function ScreenWindowField(data:BaseScreenData) {
			super(data);
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		private var _catButton:Button;

		private var _toolContainer:Sprite = new Sprite();

		private var _toolButterfly:BaseButton;

		private var _toolLadybug:BaseButton;

		private var _toolBeercup:BaseButton;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public override function added():void {
			super.added();

			if (!_catButton) {
				_catButton = Assets.getButton('buttonStartRug');
				_catButton.x = AppProperties.appWidth * 0.6;
				_catButton.y = AppProperties.appHeight * 0.8;
				_catButton.addEventListener(Event.TRIGGERED, handler_catButtonClick);
			}

			/*
			 if (!_toolBeercup) {
			 _toolBeercup = new BaseButton(GridCell.BEER_CUP);
			 _toolBeercup.addEventListener(Event.TRIGGERED, handler_toolBeercupApply);
			 _toolBeercup.x = 0;
			 _toolContainer.addChild(_toolBeercup);
			 }

			 if (!_toolButterfly) {
			 _toolButterfly = new BaseButton(GridCell.BFLY1);
			 _toolButterfly.addEventListener(Event.TRIGGERED, handler_toolButterflyApply);
			 _toolButterfly.x = _toolContainer.width + 10;
			 _toolContainer.addChild(_toolButterfly);
			 }

			 if (!_toolLadybug) {
			 _toolLadybug = new BaseButton(GridCell.LADYBUG);
			 _toolLadybug.addEventListener(Event.TRIGGERED, handler_toolLadybugApply);
			 _toolLadybug.x = _toolContainer.width + 10;
			 _toolContainer.addChild(_toolLadybug);
			 }
			 */
			addChild(_catButton);

			_toolContainer.x = 50;
			_toolContainer.y = AppProperties.appHeight * 0.8;
			addChild(_toolContainer);

		}

		//---------------------------------------------------------
		//
		// Protected methods
		//
		//---------------------------------------------------------


		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------
		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------

		private function handler_catButtonClick(event:Event):void {
			back();
		}

		private function handler_toolBeercupApply(event:Event):void {
			dispatchEventWith(EVENT_BEERCUP_APPLY);
		}

		private function handler_toolButterflyApply(event:Event):void {
			dispatchEventWith(EVENT_BUTTERFLY_APPLY);
		}

		private function handler_toolLadybugApply(event:Event):void {
			dispatchEventWith(EVENT_LADYBUG_APPLY);
		}
	}
}
