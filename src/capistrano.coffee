FolderReader      = require './handler/FolderReader'
PermissionHandler = require './handler/PermissionHandler'
Capistrano        = require './handler/Capistrano'

if (!process.env.HUBOT_CAP_DIR)
  throw new Error 'You must define the env HUBOT_CAP_DIR'

folder     = new FolderReader process.env.HUBOT_CAP_DIR
permission = new PermissionHandler folder
cap        = new Capistrano

module.exports = (robot) ->

  robot.hear /list projects/i, (msg) ->
    msg.send "Project list: #{folder.getProjects().join(', ')}"

  robot.hear /(cap|capistrano) ([a-z0-9]+) (.*)/i, (msg) ->
    project  = msg.match[2]
    command  = msg.match[3]
    username = msg.message.user.room.split('@')[0]

    if (!folder.projectExists project)
      return msg.send "This project doesn't exists."

    if (!permission.hasPermission username, project)
      msg.send "You don't have permission in this project"
      msg.send "Please talk with #{permission.getUsers(project)}" if permission.getUsers(project).length > 0
      return false

    cap.execute project, command, msg

