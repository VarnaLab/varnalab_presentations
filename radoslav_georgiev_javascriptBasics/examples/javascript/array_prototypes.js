(function(window) {

	// standart array declaration
	var arr = [1, 2, 3, 4, 5];

	// lets make an iterator ?
	// first, with function
	function iterate(arr) {
		var i = 0;
		// return a closure that keeps i in memory
		return function() {
			if(arr.length == i) {
				return false;
			}
			return arr[i++];
		}
	}

	var next = iterate(arr);
	var x;
	while( x = next()) {
		console.log(x);
	}

	// lets make iterator for all arrays
	Array.prototype.iterator = function() {
		var self = this;
		// this will be the array
		var i = 0;
		return function() {
			if(self.length == i) {
				return false;
			}
			return self[i++];
		}
	}
	console.log("Using prototype");
	next = arr.iterator();
	while( x = next()) {
		console.log(x);
	}

	// check with hasOwnProperty()
	log("Has own property check");
	for(var omg in arr) {
		if(arr.hasOwnProperty(omg)) {
			console.log(omg);
		}

	}

})(this);
