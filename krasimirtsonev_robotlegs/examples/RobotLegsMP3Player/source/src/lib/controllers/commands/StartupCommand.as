package lib.controllers.commands {
	
	import flash.events.Event;
	import lib.controllers.events.DataEvent;
	import lib.models.TracksModel;
	import lib.services.remote.DataLoaderService;
	import lib.controllers.events.PreloaderEvent;
	import org.robotlegs.mvcs.Command;
	import com.krasimirtsonev.utils.Debug;

	public class StartupCommand extends Command {
		
		private var _xmlURL:String = "tracks.xml";
		
		[Inject] public var dataLoaderService:DataLoaderService;
		[Inject] public var model:TracksModel;
		
		private function get className():String {
			return "StartupCommand";
		}
		override public function execute():void {
			Debug.echo(className + " execute");
			
			// adding listeners for the DataLoaderService's events
			eventDispatcher.addEventListener(DataEvent.ON_DATA_FAILED_TO_LOAD, onDataFailedToLoad);
			eventDispatcher.addEventListener(DataEvent.ON_DATA_LOADED, onDataLoaded);
			
			// firing the service
			dataLoaderService.load(_xmlURL);
			
			// setting the preloader text
			dispatch(new PreloaderEvent(PreloaderEvent.SET_TEXT, "Loading xml ..."));
			
		}
		private function onDataLoaded(e:DataEvent):void {
			dispatch(new PreloaderEvent(PreloaderEvent.SET_VISIBLE, false));
			model.xml = e.data;
		}
		private function onDataFailedToLoad(e:DataEvent):void {
			dispatch(new PreloaderEvent(PreloaderEvent.SET_TEXT, "Failed to load the xml data (" + _xmlURL + "). " + e.data));
		}
		
	}

}