package ru.catAndBall.data.game {
	import flash.errors.IllegalOperationError;
	import flash.events.Event;

	import ru.catAndBall.data.BaseData;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                11.09.14 8:19
	 */
	public class ResourceSet extends BaseData {

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		public static const EXPERIENCE:String = 'experience';

		public static const MONEY:String = 'money';

		public static const TOOL_COLLECT_SOCKS:String = 'toolCollectSocks';

		public static const BF_BALLS:String = 'bfBalls';

		public static const BF_SOCKS:String = 'bfSocks';

		public static const BF_SWEATERS:String = 'bfSweaters';

		public static const BF_TOYS:String = 'bgToys';

		public static const RF_BALL:String = 'rfBall';

		public static const RF_COOKIE:String = 'rfCookie';

		public static const RF_MOUSE:String = 'rfMouse';

		public static const RF_SAUSAGE:String = 'rfSausage';

		public static const RF_PIGEON:String = 'rfPigeon';

		public static const RF_CONSERVE:String = 'rfConserve';

		public static const RF_WRAPPER:String = 'rfWrapper';

		public static const RF_THREAD:String = 'rfThread';

		public static const TYPES:Vector.<String> = new <String>[
			EXPERIENCE, MONEY, BF_BALLS, BF_SOCKS, BF_SWEATERS, BF_TOYS, RF_BALL, RF_COOKIE, RF_MOUSE, RF_SAUSAGE, RF_PIGEON,
			RF_CONSERVE, RF_WRAPPER, RF_THREAD
		];

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ResourceSet() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var _hash:Object = {};

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		public function get isEmpty():Boolean {
			for (var key:String in _hash) return false;
			return true;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		[Inline]
		public final function get(resourceType:String):Number {
			return _hash[resourceType] || 0;
		}

		[Inline]
		public final function has(resourceType:String):Boolean {
			return get(resourceType) > 0;
		}

		[Inline]
		public final function set(resourceType:String, value:Number):void {
			_hash[resourceType] = value;
		}

		[Inline]
		public final function add(resourceSet:ResourceSet):void {
			if (resourceSet.isEmpty) return;

			for (var type:String in TYPES) {
				var value:Number = resourceSet._hash[type] || 0;
				if (value) addType(type, value);
			}
		}

		[Inline]
		public final function substract(resourceSet:ResourceSet):void {
			for (var type:String in TYPES) {
				var value:Number = resourceSet._hash[type] || 0;
				if (value) addType(type, -value);
			}
		}

		[Inline]
		public final function substractType(type:String, count:int):void {
			addType(type, -count);
			if (_hash[type] < 0) throw new IllegalOperationError('Cant substract more than have');
		}

		[Inline]
		public final function addType(type:String, count:int):void {
			_hash[type] ||= 0;
			_hash[type] += count;
			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		public function hasEnough(resourceSet:ResourceSet):Boolean {
			for (var type:String in TYPES) {
				var subValue:Number = resourceSet._hash[type] || 0;
				var oldValue:Number = _hash[type] || 0;
				if (subValue > oldValue) return false;
			}
			return true;
		}

		public override function deserialize(value:Object):void {
			super.deserialize(value);

			for each (var key:String in TYPES) {
				set(key, value[key] || 0);
			}
		}

		public override function serialize():Object {
			var result:Object = super.serialize();

			for each (var key:String in TYPES) {
				var value:Number = get(key);
				result[key] = value;
			}

			return result;
		}

		public function clear():void {
			for (var key:String in _hash) _hash[key] = 0;
		}
	}
}
