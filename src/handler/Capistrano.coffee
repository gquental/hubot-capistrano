spawn   = require('child_process').spawn
carrier = require 'carrier'

class Capistrano
  execute: (project, command, msg) ->
    cap = spawn 'cap', ['-f', "#{process.env.HUBOT_CAP_DIR}/#{project}/deploy.rb", command]
    @streamResult cap, msg

  streamResult: (cap, msg) ->
    capOut = carrier.carry cap.stdout
    capErr = carrier.carry cap.stderr

    capOut.on 'line', (line) ->
      msg.send line

    capErr.on 'line', (line) ->
      msg.send line

module.exports = Capistrano