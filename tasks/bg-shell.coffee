module.exports = (grunt)->
  'use strict'

  exec = require('child_process').exec

  log = grunt.log
  _ = grunt.util._

  noop = ->

  defaults =
    execOpts: null
    stdout: true
    stderr: true
    bg: false
    fail: false
    done: noop

  grunt.registerMultiTask 'bgShell', 'Run shell commands', ->
    config = _.defaults @data, grunt.config.get('bgShell')._defaults, defaults

    command = config.cmd
    command = command() if _.isFunction(command)

    stdout = config.stdout
    stderr = config.stderr

    taskDone = unless config.bg
      @async()
    else
      noop

    # stdout can be a callback or true/false
    stdoutHandler = if _.isFunction(stdout)
      stdout
    else if stdout
      (out)->
        log.write out
        return
    else
      noop

    stderrHandler = if _.isFunction(stderr)
      stderr
    else if stderr
      (err)->
        log.error err
        return
    else
      noop

    childProcess = exec(command, config.execOpts, (err, stdout, stderr) ->
      config.done(err, stdout, stderr)
      grunt.fatal err if err
      taskDone()
      return
    )

    childProcess.stdout.on 'data', stdoutHandler
    childProcess.stderr.on 'data', stderrHandler

    return


  return




