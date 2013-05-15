fs = require 'fs'

class FolderReader
  constructor: (@path) ->
    @folders = @readFolders()

  readFolders: ->
    @filterFolders fs.readdirSync @path

  filterFolders: (folders) ->
    (folder for folder in folders when (fs.statSync @path + folder).isDirectory() is true)

  getPath: ->
    @path
  
module.exports = FolderReader