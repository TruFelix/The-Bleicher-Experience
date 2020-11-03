// This code will be converted to JS
// this code will be executed on the server and remains there.
import express from 'express';
const app = express();
app.get('/', (req, res) => {
    res.send("Hello World");
});
app.get('/*', (req, res) => {
});
