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

    @FolderReader.exists path, (exists) =>
      @createProject(path, project) if exists

  getUsers: (project) ->
    @projects.get(project).getUsers(project)

  createProject: (path, project) ->
    jsonPath = "#{path}/project.json"

    @FolderReader.exists jsonPath, (exists) =>
      @projects.newProject(project, jsonPath) if exists

module.exports = PermissionHandler