_ = require("lodash")

browserifyClientOpts =

module.exports = (grunt) ->
  grunt.initConfig
    browserify:
      client:
        src: ["app/app.coffee"]
        dest: ".compiled/app.js"
        options:
          external: [
            "jQuery"
          ]
          transform: ["coffee-reactify"]
          browserifyOptions:
            debug: true
            extensions: [".cjsx", ".coffee", ".js", ".json"]

    sass:
      dist:
        files:
          "public/css/bundle.css": "scss/app.scss"
      options:
        loadPath: ["bower_components/bootstrap-sass-official/assets/stylesheets", "scss"]

    concat:
      ".compiled/bundle.js": [
        "bower_components/jquery/dist/jquery.js"
        "bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js"
        ".compiled/app.js"
      ]

    uglify:
      min:
        files:
          'public/js/bundle.js': ['.compiled/bundle.js']

    watch:
      client:
        files: ["client/**/*"]
        tasks: ["browserify", "concat", "uglify"]
      scss:
        files: ["scss/**/*"]
        tasks: ["sass"]

    nodemon:
      dev:
        script: "server.coffee"
        options:
          watch: ["server.coffee"]
          delay: 1000

    concurrent:
      dev:
        options:
          logConcurrentOutput: true
        tasks: ["watch", "nodemon"]

  grunt.loadNpmTasks "grunt-browserify"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-nodemon"
  grunt.loadNpmTasks "grunt-concurrent"

  grunt.registerTask "compile", [
    "sass"
    "browserify"
    "concat"
    "uglify"
  ]
  grunt.registerTask "default", [
    "compile"
    "concurrent"
  ]
