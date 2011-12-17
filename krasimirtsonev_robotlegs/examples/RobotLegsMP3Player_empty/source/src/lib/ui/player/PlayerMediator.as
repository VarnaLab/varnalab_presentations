package lib.ui.player {
	
	import lib.controllers.events.ListEvent;
	import org.robotlegs.mvcs.Mediator;
	import com.krasimirtsonev.utils.Debug;

	public class PlayerMediator extends Mediator {
		
		[Inject] public var view:PlayerView;
		
		private function get className():String {
			return "PlayerMediator";
		}
		override public function onRegister():void {
			Debug.echo(className + " onRegister");
			
            // transforming the events from the app to actions in the view
            // ListEvent.ON_LIST_ITEM_SELECTED --> onListItemSelected
			
		}
		private function onListItemSelected(e:ListEvent):void {
			view.playFile(e.trackVO.file, e.trackVO.name);
		}
		
	}

}