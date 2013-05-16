fs = require 'fs'

class FolderReader
  constructor: (@path) ->
    @readFolders()

    setInterval(
      =>
        @readFolders()
      5 * 60 * 1000
    )

  readFolders: ->
    @folders = @filterFolders fs.readdirSync @path

  filterFolders: (folders) ->
    (folder for folder in folders when (fs.statSync @path + folder).isDirectory() is true)

  exists: (path) ->
    fs.existsSync path

  projectExists: (project) ->
    project in @folders

  getPath: ->
    @path

module.exports = FolderReader