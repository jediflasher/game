package airlib.util.localization {


	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                04.07.15 18:23
	 */

	public function loc(key:String, args:Array = null):String {
		return Localization.make(key, args);
	}
}
