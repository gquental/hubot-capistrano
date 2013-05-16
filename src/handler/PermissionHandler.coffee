ProjectContainer = require '../project/ProjectContainer'

class PermissionHandler
  constructor: (@FolderReader) ->
    @projects = new ProjectContainer

  hasPermission: (user, project) ->
    @searchProject @FolderReader.getPath() + project, project
    @projects.get(project).hasUser user

  searchProject: (path, project) ->
    if (@projects.get(project).exists)
      return true
    if (!@FolderReader.exists(path))
      return false

    @createProject path, project

  getUsers: (project) ->
    @projects.get(project).getUsers(project)

  createProject: (path, project) ->
    jsonPath = "#{path}/project.json"

    if (!@FolderReader.exists(jsonPath))
      return false

    @projects.newProject(project, jsonPath)

module.exports = PermissionHandler