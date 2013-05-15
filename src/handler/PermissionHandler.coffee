ProjectCollection = require '../project/ProjectCollection'
cjson             = require 'cjson'

class PermissionHandler
  constructor: (@FolderReader) ->
    @projects = new ProjectCollection

  hasPermission: (user, project) ->
    @searchProject @FolderReader.getPath() + project, project
    @projects.get(project).hasUser user

  searchProject: (path, project) ->
    if (@projects.get(project).exists)
      return true
    if (!@FolderReader.exists(path))
      return false

    @createProject path, project

  createProject: (path, project) ->
    jsonPath = "#{path}/project.json"

    if (!@FolderReader.exists(jsonPath))
      return false

    json = cjson.load jsonPath

    @projects.newProject(project, json)

module.exports = PermissionHandler