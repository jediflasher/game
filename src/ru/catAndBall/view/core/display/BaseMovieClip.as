//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.view.core.display {
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * @author                Obi
	 * @version                1.0
	 * @playerversion        Flash 10
	 * @langversion            3.0
	 * @date                17.08.14 10:24
	 */
	public class BaseMovieClip extends MovieClip {

		//---------------------------------------------------------
		//
		// Constructor
		//
		//---------------------------------------------------------

		public function BaseMovieClip(textures:Vector.<Texture>, fps:Number = 12) {
			super(textures, fps);

			addEventListener(Event.ADDED_TO_STAGE, handler_addedToStage);
			addEventListener(Event.ADDED_TO_STAGE, handler_removedFromStage);
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

		private var _playing:Boolean = false;

		private var _playingOnce:Boolean = false;

		private var _onPlayOnceComplete:Function;

		//---------------------------------------------------------
		//
		// Public methods
		//
		//---------------------------------------------------------

		public function playOnce(onComplete:Function = null):void {
			play();
			_playingOnce = true;
			_onPlayOnceComplete = onComplete;
		}

		public override function play():void {
			if (!_playing) {
				_playing = true;
				if (stage) Starling.juggler.add(this);
			}

			_playingOnce = false;
			super.play();
		}

		public override function pause():void {
			if (_playing) {
				_playing = false;
				Starling.juggler.remove(this);
			}

			_playingOnce = false;
			super.pause();
		}

		public override function stop():void {
			if (_playing) {
				_playing = false;
				Starling.juggler.remove(this);
			}
			_playingOnce = false;
			super.stop();
		}

		public override function render(support:RenderSupport, parentAlpha:Number):void {
			super.render(support, parentAlpha);
		}

		public override function dispose():void {
			removeEventListener(Event.ADDED_TO_STAGE, handler_addedToStage);
			removeEventListener(Event.ADDED_TO_STAGE, handler_removedFromStage);
			_playingOnce = false;

			Starling.juggler.remove(this);
			super.dispose();
		}

		public override function advanceTime(passedTime:Number):void {
			super.advanceTime(passedTime);

			if (currentFrame >= super.numFrames - 1) {
				currentFrame = 0;
				stop();
				if (_onPlayOnceComplete is Function) _onPlayOnceComplete.apply();
			}
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

		private function handler_addedToStage(event:Event):void {
			if (_playing) {
				Starling.juggler.add(this);
			}
		}

		private function handler_removedFromStage(event:Event):void {
			if (_playing) {
				Starling.juggler.remove(this);
				_playing = false;
			}
		}
	}
}
