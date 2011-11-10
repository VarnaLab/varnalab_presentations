package lib.controllers.events {
	
	import flash.events.Event;

	public class PreloaderEvent extends Event {
		
		public static const SET_TEXT:String = "PreloaderEventSetText";
		public static const SET_VISIBLE:String = "PreloaderEventSetVisible";
		
		private var _data:*;
		
		public function PreloaderEvent(type:String, data:*) {
			super(type);
			_data = data;
		}
		override public function clone():Event {
			return new PreloaderEvent(type, _data);
		}
		public function get data():* {
			return _data;
		}
		
	}

}