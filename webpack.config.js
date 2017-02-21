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
    ],

    noParse: /\.elm$/
  },
  plugins: [
      new CopyWebpackPlugin([
          {
              from: 'src/static/img/',
              to:   'static/img/'
          },
      ]),
      new webpack.EnvironmentPlugin(["PROPOSAL_API_URL"])
  ],

  devServer: {
    inline: true,
    stats: { colors: true }
  },

};
