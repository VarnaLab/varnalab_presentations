package lib.controllers.events {
	
	import flash.events.Event;

	public class DataEvent extends Event {
		
		public static const ON_DATA_LOADED:String = "DataEventOnDataLoaded";
		public static const ON_DATA_FAILED_TO_LOAD:String = "DataEventOnDataFailedToLoad";
		public static const ON_DATA_UPDATED:String = "DataEventOnDataUpdated";
		
		private var _data:*;
		
		public function DataEvent(type:String, data:* = null) {
			super(type);
			_data = data;
		}
		public function get data():* {
			return _data;
		}
		override public function clone():Event {
			return new DataEvent(type, _data);
		}
	}

}