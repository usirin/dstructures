module.exports = (grunt) ->
  require("matchdep").filterDev("grunt-*").forEach (contrib) ->
    grunt.log.ok ["#{contrib} is loaded"]
    grunt.loadNpmTasks contrib

  grunt.initConfig
    config:
      lib: "lib"
      src: "src"

    jasmine_node:
      options:
        forceExit: true
        match: '.'
        matchall: false
        coffee: true
      all: ["spec/"]

    clean:
      lib: [
        dot: true
        src: [
          "<%= config.lib %>/*"
          "!<%= config.lib %>/.git*"
        ]
      ]

    coffee:
      lib:
        files: [
          expand: true
          cwd: "<%= config.src %>"
          src: "{,*/}*.coffee"
          dest: "<%= config.lib %>"
          ext: ".js"
        ]

    watch:
      gruntfile:
        files: "Gruntfile.coffee"
        tasks: ["coffee:lib"]

  grunt.loadNpmTasks "grunt-jasmine-node"

  grunt.registerTask "default", ["coffee"]
  grunt.registerTask "test", ["jasmine_node"]

