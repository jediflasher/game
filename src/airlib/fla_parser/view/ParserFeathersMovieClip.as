////////////////////////////////////////////////////////////////////////////////
//
//  © 2015 CrazyPanda LLC
//
////////////////////////////////////////////////////////////////////////////////
package airlib.fla_parser.view {

	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import ru.airlib.fla_parser.ObjectBuilder;
	import ru.airlib.util.t;
	import ru.swfReader.descriptors.AnimationDescriptor;
	import ru.swfReader.descriptors.DisplayObjectDescriptor;
	import ru.swfReader.descriptors.FrameDescriptor;
	import ru.swfReader.descriptors.TextFieldDescriptor;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	/**
	 * @author                    Obi
	 * @langversion                3.0
	 * @date                    22.05.2015
	 */
	public class ParserFeathersMovieClip extends ParserFeathersDisplayObjectContainer implements IAnimatable {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		private static const INVALIDATION_FLAG_FRAME:String = 'invalidationFlagFrame';

		private static const HELPER_BOUNDS:Rectangle = new Rectangle();

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const DEF:String = 'def';

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ParserFeathersMovieClip(source:DisplayObjectDescriptor) {
			super(source);
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _childrenToRemove:Vector.<DisplayObject> = new Vector.<DisplayObject>();

		private var _updated:Boolean = false;

		private var _bounds:Rectangle = new Rectangle();

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		private var _playingAnimation:Animation;

		public function get playingAnimation():Animation {
			return _playingAnimation;
		}

		private var _currentFrame:int = 1;

		public function get currentFrame():int {
			return _currentFrame;
		}

		public function get totalFrames():int {
			return source.linkage.framesCount;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		public function play(animationName:String = 'def', repeatsCount:int = 0, onComplete:Function = null, onCompleteParams:Array = null, startFrame:int = 0):void {
			if (!source.linkage.hasAnimation(animationName)) throw new Error('No animation ' + animationName);
			if (this._playingAnimation && this._playingAnimation.proto.name == animationName) return;

			var animationProto:AnimationDescriptor = source.linkage.getAnimationByName(animationName);

			var animation:Animation = new Animation();
			animation.proto = animationProto;
			animation.onComplete = onComplete;
			animation.onCompleteParams = onCompleteParams;
			animation.currentFrame = animation.proto.startFrame + startFrame;
			animation.repeatsLeft = repeatsCount > 0 ? repeatsCount : -1;

			Starling.current.juggler.add(this);
			this._playingAnimation = animation;
		}

		public function stop(applyOnComplete:Boolean = true):void {
			if (!this._playingAnimation) return;

			var onComplete:Function = this._playingAnimation.onComplete;
			var onCompleteParams:Array = this._playingAnimation.onCompleteParams;
			this._playingAnimation = null;

			if (applyOnComplete && onComplete is Function) onComplete.apply(null, onCompleteParams);
		}

		public function gotoAndStop(frame:Object):void {
			if (frame is int) {
				if (_currentFrame == frame) return;

				_currentFrame = frame as int;

				if (_currentFrame > totalFrames) _currentFrame = totalFrames;
				else if (_currentFrame < 1) _currentFrame = 1;

				invalidate(INVALIDATION_FLAG_FRAME);
				validate();
			} else {
				var animation:AnimationDescriptor = source.linkage.getAnimationByName(frame as String);
				if (!animation) return;

				this.gotoAndStop(animation.startFrame + 1);
			}
		}

		public function advanceTime(time:Number):void {
			if (!this._playingAnimation) {
				Starling.current.juggler.remove(this);
				return;
			}

			var delta:int = Math.round(60 * time);

			var animation:Animation = this._playingAnimation;
			var framesLeft:int = animation.proto.endFrame - animation.currentFrame;
			if (framesLeft > 0 && framesLeft < delta) {
				delta = framesLeft;
			}

			animation.currentFrame += delta;

			if (animation.currentFrame > animation.proto.endFrame) {
				animation.repeatsLeft--;
				if (animation.repeatsLeft == 0) {
					this.stop();
					return;
				} else {
					animation.currentFrame = animation.proto.startFrame;
					if (animation.repeatsLeft < -1) animation.repeatsLeft = -1;
				}
			}

			gotoAndStop(animation.currentFrame + 1);
		}

		public function hide(onComplete:Function = null):void {
			if (!this.visible) return;
			if (!super.stage) {
				this.visible = false;
				return;
			}

			this.play('OnHide', 1, function ():void {
				visible = false;
				if (onComplete is Function) onComplete.apply();
			});
		}

		public function show(onComplete:Function = null):void {
			if (this.visible) return;

			this.visible = true;
			this.play('OnShow', 1, onComplete);
		}

		public function hasAnimation(animation:String):Boolean {
			return source.linkage.hasAnimation(animation);
		}

		public function getFrameBounds():Rectangle {
			var frameBounds:Rectangle = source.linkage.frames[_currentFrame - 1].bounds;
			_bounds.setTo(x + t(frameBounds.x), y + t(frameBounds.y), t(frameBounds.width), t(frameBounds.height));
			return _bounds;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		protected override function draw():void {
			super.draw();

			if (isInvalid()) {
				if (this._boundArea) {
					super.setSizeInternal(t(_boundArea.width), t(_boundArea.height), false);
				}
			}

			if (isInvalid(INVALIDATION_FLAG_FRAME)) {
				updateFrame();
			}
		}

		/**
		 * @private
		 */
		protected override function initialize():void {
			super.initialize();
			updateFrame();

			if (this.hasAnimation('idle')) this.play('idle');
		}

		/**
		 * @private
		 */
		protected function updateFrame():void {
			if (source.linkage.framesCount == 1 && _updated) return;

			var frames:Vector.<FrameDescriptor> = source.linkage.frames;
			if (_currentFrame > source.linkage.framesCount) return;

			if (_playingAnimation) _currentFrame = _playingAnimation.currentFrame + 1;

			var frame:FrameDescriptor = frames[_currentFrame - 1];

//			removeChildren();

			var numChildren:int = this.numChildren;

			// update created objects
			for (var i:int = 0; i < numChildren; i++) {
				var starlingChild:DisplayObject = getChildAt(i);
				if (!frame.hasObject(starlingChild.name)) _childrenToRemove.push(starlingChild);
			}

			var len:int = _childrenToRemove.length;
			while (len--) removeChild(_childrenToRemove.pop());

			HELPER_BOUNDS.setEmpty();
			// create new objects
			numChildren = frame.objectsCount;
			for (i = 0; i < numChildren; i++) {
				var descriptorChild:DisplayObjectDescriptor = frame.objects[i];
				if (!descriptorChild) continue;

				var name:String = descriptorChild.name;
				if (!(name in _childrenHash)) {
					if (name == 'boundArea') {
						this._boundArea = descriptorChild.linkage.frames[0].bounds.clone();
					}

					if (this._customFactory && name in this._customFactory) {
						starlingChild = new (this._customFactory[name] as Class)(descriptorChild);
						starlingChild.name = name;
					} else {
						starlingChild = ObjectBuilder.build(descriptorChild);
					}

					if (starlingChild) {
						this._childrenHash[starlingChild.name] = starlingChild;
					}
				} else {
					starlingChild = _childrenHash[name];
				}

				if (!starlingChild.parent || source.linkage.framesCount > 1) addChild(starlingChild);

				starlingChild.x = t(descriptorChild.transform.tx);
				starlingChild.y = t(descriptorChild.transform.ty);
				var mtx:Matrix = starlingChild.transformationMatrix;

				mtx.copyFrom(descriptorChild.transform);
				mtx.tx = t(mtx.tx);
				mtx.ty = t(mtx.ty);
				starlingChild.transformationMatrix = mtx;
				starlingChild.alpha = descriptorChild.alpha;

				if (starlingChild is ParserFeathersTextField || starlingChild is ParserFeathersTextInput) {
					starlingChild.scaleX = 1;
					starlingChild.scaleY = 1;
					starlingChild.x = int(t((descriptorChild as TextFieldDescriptor).x));
					starlingChild.y = int(t((descriptorChild as TextFieldDescriptor).y));
					starlingChild.width = t((descriptorChild as TextFieldDescriptor).width);
					starlingChild.height = t((descriptorChild as TextFieldDescriptor).height);
				} else if (starlingChild is ParserFeathersScale9Image) {
					starlingChild.scaleX = 1;
					starlingChild.scaleY = 1;
					var b:Rectangle = descriptorChild.getFrameBounds();
					starlingChild.width = t(b.width * descriptorChild.transform.a);
					starlingChild.height = t(b.height * descriptorChild.transform.d);
				} else {
					b = descriptorChild.getFrameBounds();
					starlingChild.width = t(b.width * descriptorChild.transform.a);
					starlingChild.height = t(b.height * descriptorChild.transform.d);
				}
			}

			var frameBounds:Rectangle = source.linkage.frames[_currentFrame - 1].bounds;
			_bounds.setTo(t(frameBounds.x), t(frameBounds.y), t(frameBounds.width), t(frameBounds.height));
			setSizeInternal(_bounds.width, _bounds.height, false);

			clearInvalidationFlag(INVALIDATION_FLAG_FRAME);
			_updated = true;
		}
	}
}

import ru.swfReader.descriptors.AnimationDescriptor;

class Animation {
	public var onComplete:Function;
	public var onCompleteParams:Array;
	public var currentFrame:int;
	public var repeatsLeft:int = -1;
	public var proto:AnimationDescriptor;
}