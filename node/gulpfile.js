'use strict';

var gulp = require('gulp');
var jshint = require('gulp-jshint');

// autorun jshint
gulp.task('run-jshint', function () {
  return gulp.src(['*.js', '!gulpfile.js'])
    .pipe(jshint())
    .pipe(jshint.reporter('jshint-stylish'))
    .pipe(jshint.reporter('fail'));
});
