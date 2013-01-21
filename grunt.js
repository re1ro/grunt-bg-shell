module.exports = function (grunt) {
  "use strict";

  require('./tasks/shelly.js')(grunt);


  grunt.initConfig({
    shelly: {
      _defaults: {
        execOpts: null,
        stdout: true,
        stderr: true,
        bg: false,
        fail: false,
        done: function (err, stdout, stderr) {
        }
      },
      coffeeCompile: {
        cmd: './node_modules/coffee-script/bin/coffee -b -o ./tasks -c ./src'
      },
      coffeeWatch: {
        cmd: './node_modules/coffee-script/bin/coffee -bw -o ./tasks -c ./src',
        bg: false
      }
    }
  });


  grunt.registerTask('default', 'shelly:coffeeWatch');


};