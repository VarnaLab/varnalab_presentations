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
			return "PageComposerContext";
		}
		override public function startup():void {
			Debug.echo(className + " startup");
			
			// map singletons
			injector.mapSingleton(DataLoaderService);
			injector.mapSingleton(TracksModel);
			
			// mapping the commands
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent);
			
			// mapping views to their mediators
			mediatorMap.mapView(PreloaderView, PreloaderMediator);
			mediatorMap.mapView(ListView, ListMediator);
			mediatorMap.mapView(PlayerView, PlayerMediator);
			
			// adding the views to the stage
			contextView.addChild(new PreloaderView());
			contextView.addChild(new ListView());
			contextView.addChild(new PlayerView());
			
			// calling the startup command			
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
			
		}
		
	}

}