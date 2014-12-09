/*global module:false*/
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    // Metadata.
    pkg: grunt.file.readJSON('package.json'),
    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n',
    // Task configuration.
    coffee: {
      dist: {
        options: {

        },
        files: {
          'dist/base.js': ['coffee/base/*.coffee'],
          'dist/<%= pkg.name %>.js': [
            'coffee/*.coffee',
            'coffee/ui/*.coffee'
          ]
        }
      },
      dev: {
        options: {
          bare: true,
          sourceMap: true
        },
        files: [
          {
            expand: true,
            cwd: 'coffee',
            src: ['**/*.coffee'],
            dest: 'dev/app/scripts',
            ext: '.js'
          }, {
            expand: true,
            cwd: 'spec',
            src: ['**/*.coffee'],
            dest: 'dev/spec',
            ext: '.js'
          }
        ]
      }
    },
    concat: {
      options: {
        banner: '<%= banner %>',
        stripBanners: true,
        sourceMap: true
      },
      dist: {
        src: ['lib/**.js', 'build/js/**.js'],
        dest: 'dist/app/<%= pkg.name %>.js'
      },
      dev: {
        src: ['lib/**.js', 'build/js/**.js'],
        dest: 'dev/app/<%= pkg.name %>.js'
      }
    },
    uglify: {
      options: {
        banner: '<%= banner %>'
      },
      dist: {
        src: '<%= concat.dist.dest %>',
        dest: 'dist/app/<%= pkg.name %>.min.js'
      }
    },
    jade: {
      dist: {
        files: [{
          expand: true,
          cwd: 'jade',
          src: ['**/*.jade'],
          dest: 'dist',
          ext: '.html'
        }]
      },
      dev: {
        files: [{
          expand: true,
          cwd: 'jade',
          src: ['**/*.jade'],
          dest: 'dev/app',
          ext: '.html'
        }]
      }
    },
    sass: {
      dist: {
        files: {
          'dist/<%= pkg.name %>.css': ['sass/*.sass']
        }
      },
      dev: {
        files: {
          'dev/app/<%= pkg.name %>.css': ['sass/*.sass']
        }
      }
    },
    'http-server': {
      dev: {
        root: 'dev/app',
        port: 3000,
        host: '127.0.0.1',
        ext: 'html',
        runInBackground: true
      }
    },
    copy: {
      dist: {
        files: [{
          cwd: 'lib',
          src: '**/*',
          dest: 'dist',
          expand: true
        }, {
          cwd: 'coffee',
          src: '**/*',
          dest: 'dist',
          expand: true
        }]
      },
      dev: {
        files: [{
          cwd: 'lib',
          src: '**/*',
          dest: 'dev/app/scripts/lib',
          expand: true
        }, {
          cwd: 'coffee',
          src: '**/*',
          dest: 'dev/app/coffee',
          expand: true
        }, {
          cwd: 'data',
          src: '**/*',
          dest: 'dev/app/data',
          expand: true
        }
        ]
      }
    },
    watch: {
      coffee: {
        files: ['coffee/**/*.coffee', 'spec/*.coffee'],
        tasks: [
          'coffee:dev',
          'copy:dev'
        ]
      },
      data: {
        files: ['data/**'],
        tasks: [
          'copy:dev'
        ]
      }
    },
    jasmine: {
      dev: {
        src: ['dev/app/*.js', '!dev/app/app.js'],
        options: {
          vendor: 'dev/app/lib/*.js',
          specs: 'dev/spec/*Spec.js',
          helpers: 'dev/spec/*Helper.js'
          //summary: true
        }
      }
    },
    clean: {
      dev: ["dev", "build"]
    },
    bower: {
      dev: {
        dest: 'dev/app/scripts/lib/',
        options: {
          keepExpandedHierarchy: false
        }
      }
    }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-jade');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-http-server');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-jasmine');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-bower');

  // Default task.
  grunt.registerTask('default', [
    'clean:dev',
    'coffee:dev',
    'copy:dev',
    'jade:dev',
    'sass:dev',
    'bower:dev',
    'http-server:dev',
    'watch'
  ]);

  grunt.registerTask('dist', [
    'coffee:dist',
    'jade:dist',
    'sass:dist',
    'copy:dist'
  ]);

};
