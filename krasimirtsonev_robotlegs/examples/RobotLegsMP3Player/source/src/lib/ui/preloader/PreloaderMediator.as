package lib.ui.preloader {
	
	import lib.controllers.events.PreloaderEvent;
	import org.robotlegs.mvcs.Mediator;
	import com.krasimirtsonev.utils.Debug;

	public class PreloaderMediator extends Mediator {
		
		[Inject]
		public var view:PreloaderView;
		
		private function get className():String {
			return "PreloaderMediator";
		}
		override public function onRegister():void {
			Debug.echo(className + " onRegister");
			
			eventMap.mapListener(eventDispatcher, PreloaderEvent.SET_TEXT, onSetText, PreloaderEvent);
			eventMap.mapListener(eventDispatcher, PreloaderEvent.SET_VISIBLE, onSetVisible, PreloaderEvent);
			
		}
		private function onSetText(e:PreloaderEvent):void {
			view.setText(e.data);
		}
		private function onSetVisible(e:PreloaderEvent):void {
			view.visible = e.data;
		}
		
	}

}