function standartFunctionName(withOneArgument) {
	if( typeof (withOneArgument) === "string") {
		return "That returns the argument concatenated with a string " + withOneArgument;
	}
}

// call the function
console.log(standartFunctionName("Rado"));

var functionFromVariable = function(arg) {
	return arg * arg;
};
// call the function
functionFromVariable(10);

var arrayWithFunctions = [
function() {
	console.log("Im an anonymous function that is placed as the first element of the array")
},
function() {
	console.log("Bla blat the same")
}];

// here it's interesting

var func = arrayWithFunctions[0]; // just returns the function.
console.log(func);
// to actually call it :
arrayWithFunctions[0]();

var counter = function(value) {
	return function() {
		value++;
		console.log(value);
	}
}
var f = counter(2);
// now f is a function
console.log( typeof (f));
f();
// 3
f();
// 4
f();
// 5
console.log("----------------------");
var ff = counter(3);
ff();
ff();
// now lets have an anonymous function
(function(arg) {
	var megaCoolVar = 5;
	console.log("We are legion.", arg);
})("Rado");
// but how to execute it ?

function highorder(num/*number*/, func/*function*/) {
	return func(num);
}

console.log(highorder(5	, function(arg) {
	return arg * arg;
}));



// and lets mix arrays and functions.
var upp = ["rado", "vlado"].map(function(item) {
	return item.toUpperCase();
});
console.log(typeof(upp));
console.log(upp);

var megaCoolVar = 5;