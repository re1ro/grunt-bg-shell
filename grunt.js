module.exports = function (grunt) {
  "use strict";

  grunt.loadNpmTasks('grunt-bg-shell');


  grunt.initConfig({
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
      coffeeCompile: {
        cmd: './node_modules/coffee-script/bin/coffee -b -o ./tasks -c ./src'
      },
      coffeeWatch: {
        cmd: './node_modules/coffee-script/bin/coffee -bw -o ./tasks -c ./src',
        bg: false
      }
    }
  });


  grunt.registerTask('default', 'bgShell:coffeeWatch');

};