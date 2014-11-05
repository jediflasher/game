//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.game {

	import feathers.controls.Header;

	import ru.catAndBall.AppProperties;
	import ru.catAndBall.view.assets.AssetList;
	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.TiledImage;
	import ru.catAndBall.view.core.ui.YellowButton;

	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 21:05
	 */
	public class FieldBottomPanel extends Header {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EVENT_TOOLS_CLICK:String = 'eventToolsClick';

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function FieldBottomPanel() {
			super();
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

		private var _back:YellowButton;

		private var _tools:Button;

		private var _settings:YellowButton;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------


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

		protected override function initialize():void {
			var bg:TiledImage = new TiledImage(Assets.getTexture(AssetList.Footer_pannel_pattern));
			bg.width = AppProperties.appWidth;
			backgroundSkin = bg;

			_back = new YellowButton(AssetList.back);
			_tools = Assets.getButton(AssetList.panel_tools_tools_footer_icon);
			_settings =new YellowButton(AssetList.Footer_settings);

			leftItems = new <DisplayObject>[_back];
			centerItems = new <DisplayObject>[_tools];
			rightItems = new <DisplayObject>[_settings];

			super.initialize();
		}
	}
}