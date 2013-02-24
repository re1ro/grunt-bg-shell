module.exports = (grunt)->
  'use strict'

  exec = require('child_process').exec

  log = grunt.log
  _ = grunt.util._

  noop = -> return

  defaults =
    execOpts: null
    stdout: true
    stderr: true
    bg: false
    fail: false
    done: noop

  grunt.registerMultiTask 'bgShell', 'Run shell commands', ->
    config = _.defaults @data, grunt.config.get('bgShell')._defaults, defaults

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

    failOnError = if config.fail
      (err)->
        grunt.fatal err
        return
    else
      noop

    stderrHandler = if _.isFunction(stderr)
      (err)->
        stderr err
        failOnError err
        return
    else if stderr
      (err)->
        log.error err
        failOnError err
        return
    else
      failOnError


    childProcess = exec(config.cmd, config.execOpts, (err, stdout, stderr) ->
      config.done(err, stdout, stderr);
      stderrHandler err if err
      taskDone()
    )

    childProcess.stdout.on 'data', stdoutHandler
    childProcess.stderr.on 'data', stderrHandler

    return


  return




