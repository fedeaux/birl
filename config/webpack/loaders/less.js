const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
    use: ExtractTextPlugin.extract({
        use: ['css-loader', 'less-loader']
    }),
    test: /\.less$/
}
