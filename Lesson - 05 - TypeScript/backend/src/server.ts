// This code will be converted to JS
// this code will be executed on the server and remains there.

import { RSA_NO_PADDING } from 'constants';
import express, { Request, Response, Application } from 'express';
import fs from 'fs';

const app:Application = express();

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