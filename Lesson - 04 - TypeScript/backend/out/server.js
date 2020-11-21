// This code will be converted to JS
// this code will be executed on the server and remains there.
import express from 'express';
import fs from 'fs';
const app = express();
let mime = new Map([
    ['html', 'text/html',],
    ['txt', 'text/plain',],
    ['css', 'text/css',],
    ['gif', 'image/gif',],
    ['jpg', 'image/jpeg',],
    ['png', 'image/png',],
    ['svg', 'image/svg+xml',],
    ['js', 'application/javascript']
]);
app.get('/', (req, res) => {
    res.send("Hello World");
});
app.get('/cwd', (req, res) => {
    res.send(fs.readdirSync("./../frontend/."));
});
app.get('/custom', (req, res) => {
    const myObj2 = new CustomClass2("Bleicher", ["ListEl1", "ListEl2"]);
    const myObj = new CustomClass("Experience", myObj2);
    const myObj22 = CustomClass2.ctor2("asdf", "sdf");
    res.send("The " + myObj.obj.name + "-" + myObj.name + " contains: " + myObj.obj.list + " " + myObj.obj.superThing() + " " + myObj22.superThing() + " " + myObj22.list);
});
app.use(express.static("./../frontend"));
app.get('/*', (req, res) => {
    try {
        res.type('plain');
        if (req.url.includes('.')) {
            let reqFile = req.url.split('.');
            let reqFileType = reqFile[reqFile.length - 1];
            res.type(mime.get(reqFileType));
        }
        res.send((fs.readFileSync("./../frontend" + req.url)));
    }
    catch (error) {
        res.send(error);
    }
});
app.listen(5000, () => {
    console.log("TS-Server running at 5000");
});
class CustomClass {
    constructor(name, obj) {
        this._name = name;
        this._obj = obj;
    }
    set name(name) {
        this._name = name;
    }
    get name() {
        return this._name;
    }
    get obj() {
        return this._obj;
    }
}
class CustomClass2 {
    constructor(attr1, list) {
        this.name = attr1;
        this.list = list;
    }
    static ctor2(attr1, attr2) {
        const res = new CustomClass2(attr1);
        res.superThing = () => {
            return attr2;
        };
        return res;
    }
    superThing() {
        return this.list.length;
    }
}
