package lib.ui.player {
	
	import flash.display.MovieClip;
	import com.krasimirtsonev.utils.Debug;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.Event;;
	import flash.text.TextFieldAutoSize;

	public class PlayerView extends MovieClip {
		
		private var _clip:MovieClip;
		private var _snd:Sound;
		private var _sndChannel:SoundChannel;
		private var _file:String;
		private var _name:String;
		private var _songText:String = "";
		
		public function PlayerView() {
			_clip = new A_PlayerClip();
			_clip.x = 300;
			addChild(_clip);
			visible = false;
		}
		private function get className():String {
			return "PlayerView";
		}
		private function setText(str:String):void {
			_clip.field.autoSize = TextFieldAutoSize.LEFT;
			_clip.field.htmlText = str;
		}
		public function playFile(file:String, name:String):void {
			Debug.echo(className + " playFile file=" + file + " name=" + name);
			
			_file = file;
			_name = name;
			visible = true;
			
			
			if(_sndChannel) {
				_sndChannel.stop();
			}
			_snd = new Sound();  
			_snd.addEventListener(IOErrorEvent.IO_ERROR, sndIOError);  
			_snd.addEventListener(ProgressEvent.PROGRESS, sndProgress);  
			_snd.addEventListener(Event.COMPLETE, sndComplete);  
			_snd.addEventListener(Event.ID3, ID3content);
			_snd.load(new URLRequest(file));
			_sndChannel = _snd.play();
			
			if(!hasEventListener(Event.ENTER_FRAME)) {
				addEventListener(Event.ENTER_FRAME, loop);
			}
			
		}
		private function sndIOError(e:IOErrorEvent):void {  
			setText("<font color='#FF0000'>Error loading the file " + _file + "</font>");
		} 
		private function sndProgress(e:ProgressEvent):void {
			_clip.preloader.loading.width = e.bytesLoaded / e.bytesTotal * 276;
		}
		private function sndComplete(e:Event):void {
						
		}  
		private function ID3content(e:Event):void {  
			var id3Prop:ID3Info = e.target.id3 as ID3Info;
			var id3Str:String = "";
			for (var idName:String in id3Prop) { 
				id3Str += idName + ": " + id3Prop[idName] + "<br />";
			}
			_songText = _name + "<br /><font size='10' color='#999999'>metadata:<br />" + id3Str + "</font>";
		}
		private function loop(e:Event):void {
			if(_snd) {
				_clip.preloader.position.width = _sndChannel.position / _snd.length * _clip.preloader.loading.width;
				setText(getTime(_sndChannel.position) + " / " + getTime(_snd.length) + "<br /><br />" + _songText);
			}
		}
		private function getTime(miliseconds:Number):String {
			var seconds:Number = Math.floor(miliseconds / 1000);
			var minutes:Number = Math.floor(seconds / 60);
			seconds = Math.floor(seconds % 60);
			var result:String = "";
			result += minutes < 10 ? "0" + minutes : minutes;
			result += ":";
			result += seconds < 10 ? "0" + seconds : seconds;
			return result;
		}
		
	}

}