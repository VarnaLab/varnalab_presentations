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
		
        // injecting the model and the service (
		
		private function get className():String {
			return "StartupCommand";
		}
		override public function execute():void {
			Debug.echo(className + " execute");
			
			// adding listeners for the DataLoaderService's events
            
			
			// firing the service
			
			
			// showing the preloader text (PreloaderEvent.SET_TEXT)
			
			
		}
		private function onDataLoaded(e:DataEvent):void {
            
            // hiding the preloader
			
            
            // sending data to the model (e.data)
            
            
		}
		private function onDataFailedToLoad(e:DataEvent):void {
            
            // showing message in the preloader (PreloaderEvent.SET_TEXT);
            
            
		}
		
	}

}