// array = Map with acending integer as Key with fixed size
// Use when:
// * no special keys needed
// * duplicates allowed
// * fixed size is no problem (when it is see List)
// in JS arrays are slopy, arrays have no fixed size, indexes can be anything
let array = [ "First Text", "Last Text", "I shall be deleted" ];
array[array.length-1] = undefined; // we can do this, as all indexes outside the bounds also return undefined, but watch the for
array = array.slice(0, array.length-1);

let list = [];
list.push("First Text");
list.push("Last Text");


// map = key-value-pair = lookup-table = dictionary
// is key driven

let assocArray = [];					// array-map
let objMap = {"key4": "value4"};		// object-map
let realMap = new Map([
	["key1", "value1"],
	["key2", "value2"]
]);

assocArray["Key1"] = "value1";

objMap.Key1 = "value1";
objMap["Key2"] = "value2";

realMap.set('Key3', 'value3');


// for
console.log('\nFor loop with array');
for (let i = 0; i < array.length; i++) {
	console.log(array[i]);
}

// foreach
console.log('\nforeach loop with list');
list.forEach(value => {
	console.log(value);
});

// for-in
console.log('\nfor-in with object-map');
for (key in objMap) {
	console.log(`object[${key}] -> ${objMap[key]}`);
}

console.log('\nfor-in with associativeArray (array-map)');
for (key in assocArray) {
	console.log(`assocArray[${key}] -> ${assocArray[key]}`);
}

console.log('\nfor-of with realMap');
for (value of realMap.values()) {
	console.log(value);
}