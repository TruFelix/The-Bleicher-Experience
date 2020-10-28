let data = {
	'DATA1': 'some super important information'
};
let data2 = {
	'Data2': "some super important information the second"
};

function controllerOne(data, UItoUse) {
	let print = '';
	for (const key in data) {
		print += data[key].toUpperCase();
	}
	UItoUse(print);
}

function controllerTwo(data, UItoUse) {
	let tmpData = data;
	let print = '';
	for (const key in data) {
		print += data[key]
	}
	UItoUse(print);
}

function UIOne(print) {
	console.log(`Hello i am the UI and i show to you: '${print}'`);
}

function UITwo(print) {
	console.log(`Hello i am also an UI and I print you: '${print}'`);
}

function MVC(model, view, controller) {
	controller(model, view);
}

MVC(data, UITwo, controllerOne);
MVC(data2,UITwo, controllerOne);
MVC(data2,UITwo, controllerTwo);
MVC(data, UIOne, controllerTwo);
MVC(data2,UIOne, controllerTwo);