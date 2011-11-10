package lib.controllers.events {
	
	import flash.events.Event;
	import lib.models.vos.TrackVO;
	
	public class ListEvent extends Event {
		
		public static const ON_LIST_ITEM_SELECTED:String = "ListEventOnListItemSelected";
		
		private var _trackVO:TrackVO;
		
		public function ListEvent(type:String, trackVO:TrackVO) {
			super(type);
			_trackVO = trackVO;
		}
		public function get trackVO():TrackVO {
			return _trackVO;
		}
		override public function clone():Event {
			return new ListEvent(type, _trackVO);
		}
		
	}

}