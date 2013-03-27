require("coffee-script");
var nconf = require("nconf");
var NotifyDir = require("./notify-dir");

nconf.env().argv();
nconf.file(nconf.get("config"));

var directories = nconf.get("directories");
var mail_settings = nconf.get("mail_settings");
var defaults = nconf.get("defaults");
var debounce_timeout = nconf.get("debounce_timeout");

for (var i = directories.length; i--;) {
  new NotifyDir(directories[i], mail_settings, defaults, debounce_timeout);
}

console.log("NotifyDir started. Watching " + directories.length + " directories.")