var arr = [1, 2, 3, 4, 5];

// simple loop, the right way :

for(var i = 0, len = arr.length; i < len; ++i) {
	console.log(arr[i]);
}

var hash = {
	name : "Rado",
	age : 21
};

for(var pesho in hash) {
	console.log(pesho, hash[pesho]);
}

if(arr.constructor === Array) {
	console.log("Arr is array");
}


// we can also have such arrays

var data = [{
	name : "Rado",
	age : 21
}, {
	name : "Vitq",
	age : 21
}];

for(var j = 0, len = data.length; j < len; j++) {
	var item = data[j];
	console.log(item);
	console.log(item.name);
	var prop = "name";
	console.log(item[prop]);
}
