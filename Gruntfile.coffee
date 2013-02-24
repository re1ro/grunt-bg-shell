module.exports = (grunt) ->
  "use strict"

  require('./tasks/bg-shell') grunt

  grunt.initConfig
      bgShell:
        _defaults:
          execOpts: null
          stdout: true
          stderr: true
          bg: false
          fail: false
          done: (err, stdout, stderr) ->

        testAsync:
          cmd: 'ls'

        testSync:
          cmd: 'ls -la'
          bg: false


  grunt.registerTask 'default', 'bgShell'