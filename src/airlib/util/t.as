package airlib.util {
	
	import airlib.AppProperties;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                24.06.15 11:16
	 */

	public function t(number:Object):Number {
		return AppProperties.workspaceScale * Number(number);
	}
}
