package lib.contexts {
	
	import com.krasimirtsonev.utils.Delegate;
	import flash.display.DisplayObjectContainer;
	import lib.models.TracksModel;
	import lib.services.remote.DataLoaderService;
	import lib.controllers.commands.StartupCommand;
	import lib.ui.list.ListMediator;
	import lib.ui.list.ListView;
	import lib.ui.player.PlayerMediator;
	import lib.ui.player.PlayerView;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.base.ContextEvent;
	import com.krasimirtsonev.utils.Debug;
	import lib.ui.preloader.PreloaderMediator;
	import lib.ui.preloader.PreloaderView;
	import flash.utils.setTimeout;

	public class PlayerContext extends Context  {
		
		public function PlayerContext(view:DisplayObjectContainer) {
			super(view);
		}
		private function get className():String {
			return "PlayerContext";
		}
		override public function startup():void {
			Debug.echo(className + " startup");
			
			// DI (mapping of the model and the service)
            
			
			// mapping the commands (StartupCommand to ContextEvent.STARTUP);
            
			
			// mapping views to their mediators
            
			
			// adding the views to the stage (PreloaderView, ListView, PlayerView)
            
			
			// calling the startup command (ContextEvent.STARTUP)
			
			
		}
		
	}

}