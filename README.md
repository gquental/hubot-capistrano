hubot-capistrano
================

This is a module created to integrate capistrano with Hubot.

##Workflow

This module needs a environment variable named **HUBOT_CAP_DIR**, where will be defined the path of the folder containing all capistrano projects.

Each folder inside this directory will be a capistrano project and it will need two files, **project.json** and **deploy.rb**

The project.json is responsible to define the list of users that will be allowed to  use the project

##Configuration

The first step is to configure the path of the folder of projects in the environment variable. This path must ends with "/".

###Configuring a project
In the project json you should have a file like this

 ```javascript
{
    "users": ["user1", "user2"]
}
 ```