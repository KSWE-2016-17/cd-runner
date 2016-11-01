let child_process = require("child_process");
let bodyParser = require("body-parser");
let express = require("express");

let config = require("./config.json");

let app = express();

app.use(bodyParser.json());

config.routes.forEach((v) => {
    app[v.method](v.url, (req, res) => {
        if (req.body.ref === "refs/heads/" + v.branch) {
            child_process.execFile(v.script, [], (error, stdout, stderr) => {
                res.send(stdout + "\n" + stderr);

                console.log(stdout, stderr);
            });
        }
    });
});

let listener = app.listen(config.port, () => {
    console.log("Server listening on port " + listener.address().port);
});
