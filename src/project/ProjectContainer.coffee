Project = require './Project'

class ProjectContainer
  constructor: ->
    @projects = {}

  newProject: (name, json) ->
    @projects[name] = new Project name, json

  get: (projectName) ->
    if (!@projects[projectName])
      return new Project 'fake', false, false

    @projects[projectName]

module.exports = ProjectContainer