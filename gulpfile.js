var gulp = require('gulp');
var webpack = require('webpack-stream');

gulp.task('default', function() {
  return gulp.src('./src/js/**/*.js')
  .pipe(webpack(require('./config/webpack.config.js')))
  .pipe(gulp.dest('./dist/js'));
});
