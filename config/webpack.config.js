var webpack = require('webpack');

module.exports = {
  entry: {
    app: './src/js/index.js',
  },
  output: {
    filename: '[name].js',
  },
  plugins: [
    new webpack.ProvidePlugin({
      // makes global riot require riot library
      riot: 'riot'
    })
  ],
  module: {
    preLoaders: [
      { test: /\.tag$/, exclude: /node_modules/, loader: 'riotjs-loader', query: { type: 'none' } }
    ],
    loaders: [
      { test: /\.js$|\.tag$/, exclude: /node_modules/, loader: 'babel-loader' }
    ]
  },
};
