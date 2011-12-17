package com.krasimirtsonev.utils {
	
	import mx.core.UIComponent;

	public class UIComponentWrapper {
		
		public static function wrap(obj:*):UIComponent {
			var c:UIComponent = new UIComponent();
			c.addChild(obj);
			return c;
		}
		
	}

}