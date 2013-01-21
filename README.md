grunt-bg-shell
============

Better shell commands for [grunt](https://github.com/gruntjs/grunt). Background/parallel run

If you want to run `compass watch`, `coffee --watch --output lib/ src/` and `forever server.js` at the same time.

# Install

```sh
$ npm i grunt-bg-shell --save-dev
```


# Using

```javascript
module.exports = function (grunt) {
  grunt.initConfig({
    bgShell: {
      _defaults: {
        bg: true
      },
      
      watchCompass: {
        cmd: 'compass watch'
      },
      watchCoffee: {
        cmd: 'coffee --watch --output lib/ src/'
      },
      runNode: {
        cmd: 'node server.js',
        bg: false
      }
    }
  });
  
  
  grunt.registerTask('default', 'bgShell:watchCompass bgShell:watchCoffee bgShell:runNode');
};
```
# Important!
In example above all shell commands go to background. But not the last one. 
We tell grunt to run till `bgShell:runNode` runs 


# Options
```javascript
bgShell: {
  lsTasks: {
    cmd: 'ls -la',
    execOpts: {
      cwd: './tasks'
    },
    stdout: true,
    stderr: true,
    bg: false,
    fail: false,
    done: function(){}
  }     
}
```
* ```cmd```: command to execute
* ```execOpts```: options for 
  [```child_process.exec```](http://nodejs.org/api/child_process.html#child_process_child_process_exec_command_options_callback)
* ```stdout```: ```true```, ```false``` or ```function(out){}```
* ```stderr```: ```true```, ```false``` or ```function(err){}```
* ```bg```: background execution
* ```fail```: fail grunt on error
* ```done```: callback after execution ```function(err, stdout, stderr){}```
 
# Override defaults
```javascript
bgShell: {
  _defaults: {
    execOpts: null,
    stdout: true,
    stderr: true,
    bg: false,
    fail: false,
    done: function (err, stdout, stderr) {
    }
  },
}
```

# Developing

You need to install grunt globally:
```sh
$ npm i -g grunt
```

* Watch coffee:

```sh
$ grunt
```
