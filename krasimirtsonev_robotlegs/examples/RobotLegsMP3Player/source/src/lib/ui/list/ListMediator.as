package lib.ui.list {
	
	import flash.events.Event;
	import lib.controllers.events.DataEvent;
	import lib.controllers.events.ListEvent;
	import lib.models.vos.TrackVO;
	import org.robotlegs.mvcs.Mediator;
	import com.krasimirtsonev.utils.Debug;

	public class ListMediator extends Mediator {
		
		[Inject]
		public var view:ListView;
		
		private function get className():String {
			return "ListMediator";
		}
		override public function onRegister():void {
			Debug.echo(className + " onRegister");
			eventMap.mapListener(eventDispatcher, DataEvent.ON_DATA_UPDATED, onDataUpdated, DataEvent);			
			eventMap.mapListener(view, Event.CHANGE, onListItemSelected, Event);			
		}
		private function onDataUpdated(e:DataEvent):void {
			var dataProvider:Array = [];
			var numOfTracks:int = e.data.length;
			for(var i:int = 0; i < numOfTracks; i++) {
				var trackVO:TrackVO = e.data[i] as TrackVO;
				dataProvider.push({label:(i+1) + ". " + trackVO.name, data:trackVO});
			}
			view.dataProvider = dataProvider;
		}
		private function onListItemSelected(e:Event):void {
			dispatch(new ListEvent(ListEvent.ON_LIST_ITEM_SELECTED, view.selectedItem.data));
		}
		
	}

}