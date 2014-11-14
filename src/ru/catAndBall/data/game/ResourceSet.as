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

		public static const TOOL_SPOOL:String = 'toolSpool'; // катушка

		public static const TOOL_BROOM:String = 'toolBroom'; // метла

		public static const TOOL_TOY_BOX:String = 'toolToyBox'; // коробка для игрушек

		public static const TOOL_BOWL:String = 'toolBowl'; // миска

		public static const TOOL_SPOKES:String = 'toolSpokes'; // спицы

		public static const TOOL_TEA:String = 'toolTea';

		public static const BF_BALLS:String = 'bfBalls';

		public static const BF_SOCKS:String = 'bfSocks';

		public static const BF_SWEATERS:String = 'bfSweaters';

		public static const BF_TOYS:String = 'bgToys';

		public static const RF_BALL:String = 'rfBall';

		public static const RF_COOKIE:String = 'rfCookie';

		public static const RF_MOUSE:String = 'rfMouse';

		public static const RF_MILK:String = 'rfMilk';

		public static const RF_PIGEON:String = 'rfPigeon';

		public static const RF_CONSERVE:String = 'rfConserve';

		public static const RF_WRAPPER:String = 'rfWrapper';

		public static const RF_THREAD:String = 'rfThread';

		public static const TYPES:Vector.<String> = new <String>[
			EXPERIENCE, MONEY,
			TOOL_BOWL, TOOL_BROOM, TOOL_SPOKES, TOOL_SPOOL, TOOL_TEA, TOOL_TOY_BOX,
			BF_BALLS, BF_SOCKS, BF_SWEATERS, BF_TOYS, RF_BALL,
			RF_COOKIE, RF_MOUSE, RF_MILK, RF_PIGEON, RF_CONSERVE, RF_WRAPPER, RF_THREAD
		];

		public static function isTool(resourceType:String):Boolean {
			if (!(resourceType in _hashIsTool)) {
				_hashIsTool[resourceType] = resourceType.indexOf('tool') == 0;
			}
			return _hashIsTool[resourceType];
		}

		public static function isComponent(resourceType:String):Boolean {
			if (!(resourceType in _hashIsComponent)) {
				_hashIsComponent[resourceType] = resourceType.indexOf('rf') == 0 || resourceType.indexOf('bf') == 0;
			}
			return _hashIsComponent[resourceType];
		}

		public static function isResource(resourceType:String):Boolean {
			if (!(resourceType in _hashIsResouce)) {
				_hashIsResouce[resourceType] = resourceType == EXPERIENCE || resourceType == MONEY;
			}
			return _hashIsResouce[resourceType];
		}

		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------

		private static const _hashIsTool:Object = {};

		private static const _hashIsComponent:Object = {};

		private static const _hashIsResouce:Object = {};

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

			for each(var type:String in TYPES) {
				var value:Number = resourceSet._hash[type] || 0;
				if (value) addTypeSilent(type, value);
			}

			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		[Inline]
		public final function substract(resourceSet:ResourceSet):void {
			for each (var type:String in TYPES) {
				var value:Number = resourceSet._hash[type] || 0;
				if (value) {
					addTypeSilent(type, -value);
				}
			}

			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		[Inline]
		public final function substractType(type:String, count:int):void {
			addType(type, -count);
		}

		[Inline]
		public final function addType(type:String, count:int):void {
			addTypeSilent(type, count);
			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		public function hasEnough(resourceSet:ResourceSet):Boolean {
			for each (var type:String in TYPES) {
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
			if (hasEventListener(Event.CHANGE)) dispatchEvent(new Event(Event.CHANGE));
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

		public final function addTypeSilent(type:String, count:int):void {
			_hash[type] ||= 0;
			_hash[type] += count;
		}
	}
}
