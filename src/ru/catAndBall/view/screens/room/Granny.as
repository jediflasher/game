package ru.catAndBall.view.screens.room {
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.factorys.StarlingFactory;

	import flash.events.Event;

	import ru.catAndBall.view.assets.Assets;
	import ru.catAndBall.view.core.display.BaseSprite;

	import starling.display.Sprite;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                18.10.14 14:32
	 */
	public class Granny extends BaseSprite {

		private static const ATLAS_NAME:String = 'granny_animation';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Granny() {
			super();

			_factory.addEventListener(Event.COMPLETE, handler_parseComplete);
			_factory.parseData(Assets.getByteArray(ATLAS_NAME));
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _factory:StarlingFactory = new StarlingFactory();

		private var _armature:Armature;

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		protected override function added(event:* = null):void {
			super.added(event);

			if (_armature) {
				WorldClock.clock.add(_armature);
			}
		}

		protected override function removed(event:* = null):void {
			super.removed(event);

			if (_armature) {
				WorldClock.clock.remove(_armature);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function handler_parseComplete(event:* = null):void {
			_armature = _factory.buildArmature('grammy');
			addChild(_armature.display as Sprite);

			_armature.animation.play();
			WorldClock.clock.add(_armature);
		}
	}
}
