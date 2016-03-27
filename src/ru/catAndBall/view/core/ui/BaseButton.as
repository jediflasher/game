//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.ui {
	
	
	import feathers.controls.Button;
	
	import ru.catAndBall.view.assets.Assets;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                08.06.14 14:55
	 */
	public class BaseButton extends Button {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function BaseButton(upStateId:String, downStateId:String = null, disabledStateId:String = null) {
			defaultSkin = Assets.getImage(upStateId);
			downSkin = Assets.getImage(downStateId);
			disabledSkin = Assets.getImage(disabledStateId);
		}

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public var data:Object;
	}
}
