
// simple string
var string = "javascript is very cool :)";

// simple array :) JS have very handfull array notation
var array = [1, 2, 3, 4, 5, 6];
console.log(array);

// the thing that you cant go without
console.log("typeof(a) -> " + typeof (a));
console.log("typeof(string) -> " + typeof (string));
console.log("typeof(array) -> " + typeof (array));
// wtf ? Object :)

// what about undefined ?
console.log("typeof(somethingMissing) -> " + typeof (somethingMissing));
console.log("typeof(undefined) -> " + typeof (undefined));
console.log("typeof(typeof(undefined)) -> " + typeof ( typeof (undefined)));

// there's null, but null is not undefined
// use null to initialize empty variables, not undefined
console.log("typeof(null) -> " + typeof (null));

// few more usefull things
var toString = "54abc";
console.log("Before parseInt :" + typeof (toString));
toString = parseInt(toString);
console.log("After parseInt :" + toString + " " + typeof (toString));

var plusInf = 1.7976931348623157E+10308;
console.log("Plus infinity : " + plusInf);

var minusInf = -1.7976931348623157E+10308;
console.log("Minus infinity: " + minusInf);

console.log(Infinity);
