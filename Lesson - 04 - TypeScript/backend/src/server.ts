// This code will be converted to JS
// this code will be executed on the server and remains there.
import express, { Request, Response, Application } from 'express';
import fs from 'fs';

const app:Application = express();

const apps = [];

/* only for advanced users
dont use seriously
for (let port = 0; port < 65635; port++) {
	apps.push(express().listen(port, () => {console.log("Open port at: " + port);}));
}
*/

let mime: Map<string, string> = new Map<string, string>([
    ['html', 'text/html',],
    ['txt', 'text/plain',],
    ['css', 'text/css',],
    ['gif', 'image/gif',],
    ['jpg', 'image/jpeg',],
    ['png', 'image/png',],
    ['svg', 'image/svg+xml',],
    ['js', 'application/javascript']
]);

app.get('/', (req: Request, res: Response) => {
	res.send("Hello World");
});

app.get('/cwd', (req: Request, res: Response) => {
	res.send(fs.readdirSync("./../frontend/."));
});

app.get('/custom', (req, res) => {
	const myObj2 = new CustomClass2("Bleicher", ["ListEl1", "ListEl2"]);
	const myObj = new CustomClass("Experience", myObj2);
	const myObj22 = CustomClass2.ctor2("asdf", 1234);

	(async () => console.log(await myObj2.Event()))();

	res.send("The " + myObj.obj.name + "-" + myObj.name + " contains: " + myObj.obj.list + " " + myObj.obj.superThing() + " " + myObj22.superThing() + " " + myObj22.list);
});

app.use(express.static("./../frontend"));

app.get('/*', (req:Request, res: Response) => {
	try {
		res.type('plain');
		
		if (req.url.includes('.')) {
			let reqFile = req.url.split('.');
			let reqFileType: string = reqFile[reqFile.length-1];
			
			res.type(mime.get(reqFileType) as string);
		}

		res.send((fs.readFileSync("./../frontend" + req.url)));

		
	} catch (error) {
		res.send(error);
	}
});

app.listen(5000, () => {
	console.log("TS-Server running at 5000");
});

class CustomClass {
	private _name: string;
	private _obj: CustomClass2;

	constructor(name:string, obj: CustomClass2) {
		this._name = name;
		this._obj = (obj as CustomClass2);
	}
	
	public set name(name: string) {
		this._name = name;
	}
	
	public get name() : string {
		return this._name;
	}
	
	
	public get obj() : CustomClass2 {
		return this._obj
	}

	public static async eventHandler(event:any) {
		return await event;
	}
}

class CustomClass2 {
	public name: string;
	public list: string[];

	constructor(attr1:string, list:string[]) {
		this.name = attr1;
		this.list = list;
	}

	public static ctor2(attr1:string, attr2: number) : CustomClass2 {
		const res = new CustomClass2(attr1, []);
		res.superThing = () => {
			return attr2;
		}
		return res;
	}

	public superThing(): number {
		return this.list.length;
	}

	public Event() {
		return new Promise((resolve) => setTimeout(() => {
			resolve("event happened");
		}, 2000));
	}
}