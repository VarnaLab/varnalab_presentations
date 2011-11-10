package lib.ui.list {
	
	import fl.data.DataProvider;
	import flash.display.MovieClip;
	import com.krasimirtsonev.utils.Debug;
	import flash.events.Event;

	public class ListView extends MovieClip {
		
		private var _clip:MovieClip;
		
		public function ListView() {
			_clip = new A_ListClip();
			_clip.list.width = _clip.list.height = 300;
			_clip.list.addEventListener(Event.CHANGE, onListItemSelected);
			addChild(_clip);
			visible = false;
		}
		private function get className():String {
			return "ListView";
		}
		public function set dataProvider(dp:Array):void {
			_clip.list.dataProvider = new DataProvider(dp);
			visible = true;
		}
		public function get selectedItem():Object {
			return _clip.list.selectedItem;
		}
		private function onListItemSelected(e:Event):void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}

}