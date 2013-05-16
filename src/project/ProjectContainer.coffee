Project = require './Project'

class ProjectContainer
  constructor: ->
    @projects = {}

  newProject: (name, json) ->
    @projects[name] = new Project name, json

  get: (projectName) ->
    if (!@projects[projectName])
      return {
        exists: false,
        hasUser: (user) ->
          false
      }

    @projects[projectName]

module.exports = ProjectContainer