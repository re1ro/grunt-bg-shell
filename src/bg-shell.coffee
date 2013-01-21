module.exports = (grunt)->
  'use strict'

  exec = require('child_process').exec

  log = grunt.log
  _ = grunt.utils._

  noop = -> return

  defaults =
    execOpts: null
    stdout: true
    stderr: true
    bg: false
    fail: false
    done: noop

  grunt.registerMultiTask 'bgShell', 'Run shell commands', ->
    data = _.defaults @data, grunt.config.get('bgShell')._defaults, defaults

    stdout = data.stdout
    stderr = data.stderr

    taskDone = unless data.bg
      @async()
    else
      noop

    stdoutHandler = if _.isFunction(stdout)
      stdout
    else if stdout
      (out)->
        log.write out
        return
    else
      noop

    failOnError = (err)->
      grunt.fatal err if data.fail
      return

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


    childProcess = exec(data.cmd, data.execOpts, (err, stdout, stderr) ->
      data.done(err, stdout, stderr);
      stderrHandler err if err
      taskDone()
    )

    childProcess.stdout.on 'data', stdoutHandler
    childProcess.stderr.on 'data', stderrHandler

    return


  return




