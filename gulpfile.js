var gulp = require('gulp');
var webpack = require('webpack-stream');
var del = require('del');
var copy = require('gulp-copy');
var bs = require('browser-sync').create();

gulp.task('clean:dist', function() {
  return del(['dist/**/*']);
});

gulp.task('webpack', function() {
  return gulp
    .src('./src/js/**/*.js')
    .pipe(webpack(require('./config/webpack.config')))
    .pipe(gulp.dest('./dist/js'))
    .pipe(bs.stream());
});

gulp.task('static:copy', function() {
  return gulp
    .src('./src/static/**/*')
    .pipe(copy('./dist/', {prefix: 2}));
});

gulp.task('serve', function() {
  bs.init(require('./config/browser-sync'));
  gulp.watch('./src/static/**/*', ['static:copy']).on('change', bs.reload);
  gulp.watch('./src/js/**/*.js', ['webpack']);
});

gulp.task('default', ['clean:dist', 'webpack', 'static:copy']);
