var CopyWebpackPlugin = require( 'copy-webpack-plugin' );
require('dotenv').config();
var path = require("path");
var webpack = require("webpack");

module.exports = {
  entry: {
    app: [
      './src/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  module: {
    loaders: [
      {
        test: /\.(css|scss)$/,
        loaders: [
          'style-loader',
          'css-loader',
        ]
      },
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file?name=[name].[ext]'
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack?verbose=true&warn=true'
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff'
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader'
      },
    ]
  },
  plugins: [
      new CopyWebpackPlugin([
          {
              from: 'src/static/img/',
              to:   'static/img/'
          },
      ]),
      new webpack.EnvironmentPlugin(["API_BASE_URL"])
  ],

  devServer: {
    inline: true,
    stats: { colors: true }
  },

  node: {
    // console: 'empty',
    fs: 'empty',
    net: 'empty',
    tls: 'empty'
    // console: false,
    // global: true,
    // process: true,
    // Buffer: true,
    // __filename: "mock",
    // __dirname: "mock",
    // setImmediate: true
  }
};
