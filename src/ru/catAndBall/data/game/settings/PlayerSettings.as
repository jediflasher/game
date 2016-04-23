package ru.catAndBall.data.game.settings {
	
	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                09.04.2016 19:03
	 */
	public class PlayerSettings {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function PlayerSettings() {
			super();
		}

		public var levelMultiplier:Number;
		
		public function deserialize(input:Object):void {
			if ('levelMultiplier' in input) levelMultiplier = input.levelMultiplier;
		}
	}
}
