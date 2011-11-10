package lib.services.remote {
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.robotlegs.mvcs.Actor;
	import com.krasimirtsonev.utils.Debug;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import lib.controllers.events.DataEvent;

	public class DataLoaderService extends Actor {
		
		private var _url:String = "";
		private var _loader:URLLoader;
		
		public function DataLoaderService() {
			super();
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onDataLoad);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onDataFiledToLoad);
			_loader.addEventListener(IOErrorEvent.NETWORK_ERROR, onDataFiledToLoad);
			_loader.addEventListener(IOErrorEvent.VERIFY_ERROR, onDataFiledToLoad);
			_loader.addEventListener(IOErrorEvent.DISK_ERROR, onDataFiledToLoad);
		}
		private function get className():String {
			return "XMLLoader";
		}
		public function load(url:String):void {
			Debug.echo(className + " loadXML url=" + url);
			_url = url;
			_loader.load(new URLRequest(_url));			
		}
		private function onDataLoad(e:Event):void {
			eventDispatcher.dispatchEvent(new DataEvent(DataEvent.ON_DATA_LOADED, e.target.data));
		}
		private function onDataFiledToLoad(e:IOErrorEvent):void {
			eventDispatcher.dispatchEvent(new DataEvent(DataEvent.ON_DATA_FAILED_TO_LOAD, e.text));
		}
		
	}

}