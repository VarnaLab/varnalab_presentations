package lib.models {	
	
	import flash.events.Event;
	import lib.controllers.events.DataEvent;
	import lib.models.vos.TrackVO;
	import org.robotlegs.mvcs.Actor;
	import com.krasimirtsonev.utils.Debug;

	public class TracksModel extends Actor {
		
		private var _tracks:Array;
		
		public function TracksModel() {
			super();
		}
		private function get className():String {
			return "TracksModel";
		}
		public function set xml(xmlStr:String):void {
			
			_tracks = [];
			
			var xml:XML = new XML(xmlStr);
			var numOfTrags:int = xml.tracks.t.length();
			for(var i:int=0; i<numOfTrags; i++) {
				var trackNode:XML = xml.tracks.t[i];
				var vo:TrackVO = new TrackVO();
				vo.name = trackNode.@name;
				vo.file = trackNode.@file;
				_tracks.push(vo);
			}
			
			dispatch(new DataEvent(DataEvent.ON_DATA_UPDATED, _tracks));            
			
		}
		public function get tracks():Array {
			return _tracks;
		}
		
	}

}