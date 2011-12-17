(function(window) {

	var x = {

	};
	// JSON
	var x1 = new Object();

	var jsonObject = {
		'a' : 5,
		'b' : 5,
		'something' : function() {
			console.dir(this);
		},
		'array' : [1, 2, 3, 4, 5]
	}

	jsonObject.something();
})(this);
