<pre>
        ____          _            _  __     __  _ ___     ___  _        
       / __/_ _  ____(_)__ ___    / |/ /__  / /_(_) _/_ __/ _ \(_)___    
      / _//  ' \/ __/ / -_) _ \  /    / _ \/ __/ / _/ // / // / / __/    
     /___/_/_/_/\__/_/\__/_//_/ /_/|_/\___/\__/_/_/ \_, /____/_/_/       
                                                   /___/                 
</pre>  
                                                                                                      

A directory monitor that detects new and modified files and sends email notifications.

## Configuration

A config file can be loaded via a config flag.

    notify-dir --config config.json

The config file should contain the following:

### directories
An array of directories to be watched. Each directory object must contain a path, and can optionally contain per directory overrides for email message defaults.

### defaults
Defaults to be used when sending notification emails.
 - to: email address to send to
 - from: email address to send from
 - subject: subject of notification emails
 - html: initial html of notification emails
 - text: initial text of notification emails

### mail_settings
Settings to be used for sending notification emails. Mail settings must contain a value for transport ("SMTP", "sendmail", etc.). The option key must be present and can be used to set things like path, service, auth, and more, but can also be left empty.

### debounce_timeout
This is how long to wait (in milliseconds) before firing the notification. A low value may cause files undergoing long file operations to notify more than once.

## Questions?

Talk to Markle