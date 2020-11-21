import express from 'express';

const app = express();
app.listen(1234, () => {
	console.log("TS/basic-server running at 1234");
});

app.get("/", (req, res) => res.send("HelloWorld"));