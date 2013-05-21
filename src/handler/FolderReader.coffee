fs = require 'fs'

class FolderReader
  constructor: (@path) ->
    @folders = []

    @readFolders()

    setInterval(
      =>
        @readFolders()
      1000
    )

  readFolders: ->
    fs.readdir @path, (err, folders) =>
      throw new Error err if err
      
      @folders = []
      @filterFolders folders


  filterFolders: (folders) ->
    folders.forEach (folder) =>
      fs.stat @path + folder, (err, stat) =>
        throw new Error err if err

        @folders.push(folder) if stat.isDirectory()

  exists: (path, callback) ->
    fs.exists path, (exists) ->
      callback exists

  projectExists: (project) ->
    project in @folders

  getPath: ->
    @path

  getProjects: ->
    @folders

module.exports = FolderReader