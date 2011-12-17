package lib.ui.preloader {
	
	import flash.display.MovieClip;

	public class PreloaderView extends MovieClip {
		
		private var _clip:MovieClip;
		
		public function PreloaderView() {
			_clip = new A_FieldClip();
			_clip.field.text = "";
			addChild(_clip);
			x = y = 15;
			visible = false;
		}
		public function setText(str:String):void {
			_clip.field.htmlText = str;
			visible = true;
		}
		
	}

}