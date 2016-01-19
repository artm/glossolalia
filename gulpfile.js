var gulp = require('gulp');
var webpack = require('webpack-stream');
var del = require('del');
var copy = require('gulp-copy');

gulp.task('clean:dist', function() {
  return del(['dist/**/*']);
});

gulp.task('webpack', function() {
  return gulp
    .src('./src/js/**/*.js')
    .pipe(webpack(require('./config/webpack.config.js')))
    .pipe(gulp.dest('./dist/js'));
});

gulp.task('static:copy', function() {
  return gulp
    .src('./src/static/**/*')
    .pipe(copy('./dist/', {prefix: 2}));
});

gulp.task('default', ['clean:dist', 'webpack', 'static:copy']);
