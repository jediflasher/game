package airlib.util {

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author              Roman
	 * @version             1.0
	 * @playerversion       Flash 11
	 * @langversion         3.0
	 * @date                01.11.2015 10:49
	 */
	public function traceObject (obj:*, traceIt:Boolean=true, shift:String=null, hash: Dictionary = null):String {
		if(!hash) hash = new Dictionary();
		var isSimple: Boolean = (obj is Number) || (obj is String) || (obj is Boolean) || (obj == null);
		if(!isSimple){
			if(hash[obj]) {
				return shift + "@link";
			}
			hash[obj] = obj;
		}

		shift ||= '-> ';
		var str:String = '';

		for(var ind:String in obj) {
			var part:String = traceObject(obj[ind], false, '-' + shift, hash);
			str += '\n' + shift + ind + ' : ';
			if(obj[ind] is Array || getQualifiedClassName(obj[ind]) == 'Object') {
				if(part.indexOf('[Empty') != 0) { str += '[' + getQualifiedClassName(obj[ind]) + ']'; }
			}
			str += part;
		}

		if(str == '') {
			if (obj is Array || getQualifiedClassName(obj) == 'Object') { str = '[Empty ' + getQualifiedClassName(obj) + ']'; }
			else { str = obj + ''; }
		}

		if (traceIt) trace(str);
		return str;
	}
}
