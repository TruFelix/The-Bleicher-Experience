async function asyncCall() {
	console.log('calling');
	const result = await new Promise(resolve => {
		setTimeout(() => {
			resolve('resolved');
		}, 2000);
	});
	console.log(result);
}

asyncCall();
console.log("I am after asyncCall")