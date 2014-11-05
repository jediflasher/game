//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game.field {

	import feathers.core.FeathersControl;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;

	import starling.core.RenderSupport;
	import starling.display.Image;
	import starling.display.Sprite;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 17:22
	 */
	public class FieldProgressPanel extends FeathersControl {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function FieldProgressPanel() {
			super();

			touchable = false;
			update();
		}

		//---------------------------------------------------------
		//
		// Properties
		//
		//---------------------------------------------------------

		private var _progress:Number = 0;

		public function get progress():Number {
			return _progress;
		}

		public function set progress(value:Number):void {
			if (_progress == value) return;

			_progress = value;
			_needUpdate = true;
		}

		//---------------------------------------------------------
		//
		// Variables
		//
		//---------------------------------------------------------

		/**
		 * @private
		 */
		private var _needUpdate:Boolean = true;

		private var _cat:Image;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		protected override function initialize():void {
			super.initialize();

			update();
		}

		//---------------------------------------------------------
		//
		// Private methods
		//
		//---------------------------------------------------------

		private function update():void {
			if (!_cat) {
				_cat = Assets.getImage(AssetList.Strip_moves_cat_for_strip);
				_cat.y = 30 - _cat.height / 2;
				addChild(_cat);
			}

			var start:Number = AppProperties.appWidth * 0.1;
			var totalPath:Number = AppProperties.appWidth - (start * 2 + _cat.width);

			_cat.x = start + totalPath * _progress;
		}

		//---------------------------------------------------------
		//
		// Event handlers
		//
		//---------------------------------------------------------
	}
}
