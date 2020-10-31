import express, { Response, Request } from "express";

let app = express();

app.get("/", (res: Response, req: Request) => {
	res.send("<h1>Hello</h1>");
});

app.listen(5000, () => {
	console.log("Running 5000");
});