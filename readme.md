# Cross SIte Script

Same origin prevents from accessing data from other domains. But if we can inject a script into a page, we can bypass this restriction.
If you are executing JS at the client browser of the victim, you can do anything you want. You can read generic information, cookies, send requests, etc.
This is a blind scenario. We can't see the result of our attack. We need to send the result to our server.

We need to create a connection between the victim and our server. 
Session hijacking is a good way to do this. We can use the victim's session to send the result of our attack to our server.

Corss site trace is another way to do this.

Reflected XXS Send a script to user that will make a request to target server.

## How to inject a script?