class Project
  constructor: (@name, json) ->
    @users  = json.users
    @exists = true

  hasUser: (user) ->
    user in @users

module.exports = Project