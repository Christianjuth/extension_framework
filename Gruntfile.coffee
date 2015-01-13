
module.exports = (grunt) ->
  #require it at the top and pass in the grunt instance
  require('time-grunt')(grunt)
  require('load-grunt-tasks')(grunt)

  #Load extension config file
  config = grunt.file.readJSON("app/configure.json")

  #Project functions
  grunt.initConfig {

  pkg: grunt.file.readJSON('package.json'),

  #scripts and styles
  less : grunt.file.readJSON('grunt/less.json')
  coffee : grunt.file.readJSON('grunt/coffee.json')
  uglify : grunt.file.readJSON('grunt/uglify.json')

  #icons
  multiresize : grunt.file.readJSON('grunt/multiresize.json')

  #manage files
  clean :
    libs : ['app/js/libs/ext.js']
    builds : ['builds/*.zip', '!builds/archive', '!builds/' + config.version + '*']

  rsync : grunt.file.readJSON('grunt/rsync.json')
  copy :
    archive :
      src: ['*.zip', '!' + config.version + '*'],
      expand: true,
      cwd: 'builds/',
      dest: 'builds/archive/'

  #package
  imagemin : grunt.file.readJSON('grunt/imagemin.json')
  compress :
    chrome :
      options :
        archive : 'builds/' + config.version + '-chrome.zip'
      src: ['**/*', '!Settings.plist', '!Info.plist', '!assets/icons/**/*-16.png', '!icon-96.png', '!icon-64.png', '!icon-32.png'],
      expand: true,
      cwd: 'builds/latest.safariextension/',

  browserDependencies :
    define :
      dir : 'app/js/libs/',
      files: [{
        'ext.js': 'http://code.ext-js.org/ext.js'
      }]

  extension_manifest :
    default :
      file: 'app/configure.json',
      dest: 'builds/latest.safariextension/'

  #other
  notify_hooks : grunt.file.readJSON('grunt/notify_hooks.json')

  }

  #register tasks
  grunt.registerTask 'assets', ['less:default','coffee:default']
  grunt.registerTask 'img', ['multiresize', 'rsync:icons', 'imagemin']
  grunt.registerTask 'archive', ['copy:archive', 'clean:builds']
  grunt.registerTask 'package-chrome', ['compress:chrome']


  #update scripts, styles, images, and new files
  grunt.registerTask 'compile', [
    'clean:libs'
    'browserDependencies',
    'extension_manifest',
    'rsync:package',
    'img',
    'assets'
  ]

  #clean all old files, rebuild, and package for store
  grunt.registerTask 'package', [
    'compile'
    'package-chrome',
    'archive'
  ]

  #update new script and style files only
  grunt.registerTask 'default', [
    'package'
  ]

  grunt.task.run('notify_hooks')
