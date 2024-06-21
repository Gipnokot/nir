const path = require('path');

module.exports = {
  mode: 'development', // или 'production' в зависимости от вашего окружения
  entry: {
    main: path.resolve(__dirname, './app/assets/javascripts/application.js')
  },
  output: {
    path: path.resolve(__dirname, './dist'),
    filename: '[name].bundle.js'
  }
};
