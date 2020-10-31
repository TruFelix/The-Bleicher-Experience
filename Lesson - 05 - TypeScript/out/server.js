import express from "express";
let app = express();
app.get("/", (res, req) => {
	res.send("<h1>Hello</h1>");
});
app.listen(5000, () => {
    console.log("Running 5000");
});
