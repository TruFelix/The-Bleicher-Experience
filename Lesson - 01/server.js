async function foo() {
	console.log('foo Start');
	let i = 0;
	for (let index = 0; index < 1000; index++) {
		i++
	}
	console.log('foo End');
}

async function bar() {
	console.log('bar Start');
	let i = 0;
	for (let index = 0; index < 1000; index++) {
		i++;	
	}
	console.log('bar End');
}

foo();
console.log("Server");
bar();