var fs = require("fs");
var readline = require("readline-sync")

var config = {};
if(fs.statSync().isFile()) {
    fs.readFile("config.json", function (err, data) {
        if (err != undefined && err != null)
            return JSON.parse(data);
    });
}
else{ //set up initial config
    console.log("Config File not found, please enter your data");
    newConfig();
 }

function newConfig() //Contains relevant information for configuration
{
    config.batMin = readline.questionInt("What battery level(int in percent) would you define as  \" living dangerously\" ");
    config.pushbullet = readline.question("Please enter(copy paste) a pushbullet Token");

    fs.writeFile("config.js", JSON.stringify(config), function(err){
        if(err)
            console.log(err);
        else
            console.log("New Configuration Saved");
    });

}