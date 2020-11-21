"use strict";
exports.__esModule = true;
var express_1 = require("express");
var app = express_1["default"]();
app.listen(1234, function () {
    console.log("TS/basic-server running at 1234");
});
app.get("/", function (req, res) { return res.send("HelloWorld"); });
