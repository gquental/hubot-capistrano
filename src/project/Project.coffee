cjson = require 'cjson'

class Project
  constructor: (@name, @jsonPath, @exists = true) ->
    @users  = []

    @updateUsers()

    setInterval(
      =>
        @updateUsers()
      1000
    )

  hasUser: (user) ->
    user in @users

  getUsers: ->
    @users.join ', '

  updateUsers: ->
    if @jsonPath
      json = cjson.load @jsonPath
      @users = json.users

module.exports = Project