'use strict';

module.exports = function (grunt) {
  // load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(function(contrib) {
    grunt.log.ok([contrib + " is loaded"]);
    grunt.loadNpmTasks(contrib);
  });

  var config = {
    dist: 'dist',
    src: 'src',
  };

  // Project configuration.
  grunt.initConfig({
    config: config,

    jasmine_node: {
      options: {
        forceExit: true,
        match: '.',
        matchall: false,
        coffee: true,
      },
      all: ['spec/']
    },

    clean: {
      dist: {
        files: [
          {
            dot: true,
            src: [
              '<%= config.dist %>/*',
              '!<%= config.dist %>/.git*'
            ]
          }
        ]
      },
    },
    coffee: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= config.src %>',
          src: '{,*/}*.coffee',
          dest: '<%= config.dist %>',
          ext: '.js'
        }]
      },
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      gruntfile: {
        src: 'Gruntfile.js'
      },
    },
    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      },
      dist: {
        files: '<%= config.src %>/*',
        tasks: ['coffee:dist']
      },
    },
  });

  grunt.loadNpmTasks('grunt-jasmine-node');

  // Default task.
  grunt.registerTask('default', ['coffee', 'jshint']);

  grunt.registerTask('test', ['jasmine_node']);

  grunt.registerTask('coverage', [
    'clean',
    'coffee',
    'coverageBackend'
  ])
};
