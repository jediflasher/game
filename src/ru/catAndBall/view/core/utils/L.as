package ru.catAndBall.view.core.utils {
	import ru.catAndBall.utils.str;

	/**
	 * @author              Obi
	 * @version             1.0
	 * @playerversion       Flash 10
	 * @langversion         3.0
	 * @date                29.09.14 21:55
	 */
	public class L {

		public static function get(text:String, args:Array = null):String {
			text = str(dict[text] || text, args);
			return text;
		}

		private static const dict:Object = {
			'start_field_popup.balls.title': 'Rolls',
			'start_field_popup.balls.desc': 'There is super beautiful field you can get in there and fuck off',
			'start_field_popup.balls.start': 'Start',
			'finish_field_popup.balls.title': 'It was very useful day! Hooray!',
			'finish_field_popup.balls.desc': '+%s experience',
			'finish_field_popup.balls.take': 'Take',
			'start_field_popup.rug.title': 'Rug',
			'start_field_popup.rug.desc': 'There is super beautiful field. You should pay money.',
			'inventory.title': 'Inventory',
			'inventory.tab0': 'Tools',
			'inventory.tab1': 'Resources',
			'tool.toolSpool.name': 'Spool',
			'tool.toolSpool.desc': 'Spool very interesting description about some shit',
			'tool.toolBroom.name':'Broom',
			'tool.toolBroom.desc':'Broom very interesting description about some shit',
			'tool.toolToyBox.name': 'Toy box',
			'tool.toolToyBox.desc': 'Toy box very interesting description about some shit',
			'tool.toolBowl.name': 'Bowl',
			'tool.toolBowl.desc': 'Bowl very interesting description about some shit',
			'tool.toolSpokes.name': 'Spokes',
			'tool.toolSpokes.desc': 'Spokes very interesting description about some shit',
			'tool.toolTea.name': 'Cup of coffee',
			'tool.toolTea.desc': 'Cup of coffee very interesting description about some shit',
			'screen.craft.tabRug.title': 'Ruf',
			'screen.craft.tabRolls.title': 'Rolls',
			'screen.craft.tabWindow.title': 'Window',
			'screen.craft.makeButton': 'Create',
			'screen.craft.popup.makeFree': 'Create',
			'screen.craft.popup.makeFor': 'Create for %s',
			'screen.bank.buy_button': 'Take %s',
			'screen.bank.clear_button': 'Reset all to 0',
			'screen.room.popupPaid.makeFor': 'Start for %s',
			'screen.room.popupPaid.makeFree': 'Start',
			'construction.hint.done':'Done',
			'construction.hint.locked':'Not built yet',
			'construction.catHouse.name': 'Cat House',
			'construction.catHouse.desc': 'Very beautiful house \nfor cat. \nShe can leave in it so long \nas she want.',
			'construction.commode1.name': 'First commode shelf',
			'construction.commode1.desc': 'First commode shelf. You can use it to create some tools.',
			'construction.commode2.name': 'Second commode shelf',
			'construction.commode2.desc': 'Second commode shelf. You can use it to create some tools.',
			'construction.commode3.name': 'Third commode shelf',
			'construction.commode3.desc': 'Third commode shelf. You can use it to create some tools.'
		};

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function L() {
			super();
		}
	}
}
