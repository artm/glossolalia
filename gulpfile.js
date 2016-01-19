var gulp = require('gulp');
var webpack = require('webpack-stream');
var del = require('del');

gulp.task('clean:dist', function() {
  return del(['dist/**/*']);
});

gulp.task('webpack', function() {
  return gulp.src('./src/js/**/*.js')
  .pipe(webpack(require('./config/webpack.config.js')))
  .pipe(gulp.dest('./dist/js'));
});

gulp.task('default', ['clean:dist', 'webpack']);
