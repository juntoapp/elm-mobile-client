var path = require('path');

module.exports = {
  // If your entry-point is at "src/index.js" and
  // your output is in "/dist", you can ommit
  // these parts of the config
  module: {
    rules: [{
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader',
        options: {
          files: [
            path.resolve(__dirname, "src/Main.elm"),
          ],
          debug: true
        }
      }
    ]
  },

  devServer: {
    inline: true,
    stats: 'errors-only'
  }
};
