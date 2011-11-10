package lib {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import lib.contexts.PlayerContext;
	import mx.containers.Canvas;
	import com.krasimirtsonev.utils.UIComponentWrapper;
	
	public class App extends Canvas {
		
		private var _holder:MovieClip;
		private var _context:PlayerContext;
				
		public function App() {
			
			// adding the main holder
			_holder = new MovieClip();
			addChild(UIComponentWrapper.wrap(_holder));
			
			// creating the Context of the application
			_context = new PlayerContext(_holder);
			
		}
	}
	
}