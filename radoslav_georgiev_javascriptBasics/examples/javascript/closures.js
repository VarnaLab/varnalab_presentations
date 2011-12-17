(function(window) {

	var closure = function() {
		var x = 5;
		return function() {
			return ++x;
		}
	}
	var c1 = closure();
	console.log(c1());
	// 6
	console.log(c1());
	// 7

	var c2 = closure();
	console.log(c2());
	// 6

	// valid
	(function() {}()); 
	// valid
	(function() {})();

	// closures and loops are tricky
	var loopsGotcha = function() {
		var list = [];
		for( i = 0; i < 4; i++) {
			var item = "item" + i;
			list[i] = (function(item) {
				return function() {
					console.log(item);
				}
			})(item);
		}
		return list;
	}
	var list = loopsGotcha();
	var n = list.length;
	for(var i = 0; i < n; i++) {
		var func = list[i];
		func();
	}

})(this);
// this === window

// nothing from up can be seen here