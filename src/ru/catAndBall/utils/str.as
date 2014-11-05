//////////////////////////////////////////////////////////////////////////////////
//
//  © 2011 Crazy Panda
//
//////////////////////////////////////////////////////////////////////////////////
package ru.catAndBall.utils {

	public function str(exp:String, args:Array = null):String {
		if (args) {
			var count:int = 0;
			while(exp.indexOf('%s') >= 0 && count++ < 100) {
				exp = exp.replace('%s', args.shift());
			}
		}
		return exp;
	}

}
