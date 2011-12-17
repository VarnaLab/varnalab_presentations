(function(window) {
	var Person = function(name) {
		this.name = name; // own property
		this.intelligence = 0;

		this.sayHi = function() {
			return "Hello from, " + this.name;
		};

		// chaining
		this.addIntelligence = function(val) {
			if(typeof(val) === "number") {
				this.intelligence += val;
				return this;			
			} else {
				console.log("val is not a number :(");
			}
		}
	}


	var p = new Person("Rado");
	console.dir(p);
	console.log(p.name);
	console.log(p.sayHi());
	
	// chaining 
	// jQuery !!!!!!
	p.addIntelligence(5).addIntelligence(5).addIntelligence(5);
	console.log(p.name + " intelligence is " + p.intelligence);

})(this);
