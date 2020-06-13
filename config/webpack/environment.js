const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')
const pug =  require('./loaders/pug')
const vue =  require('./loaders/vue')

const VueLoaderPlugin = require('vue-loader/lib/plugin')

environment.loaders.append('coffee', coffee)
environment.loaders.append('pug', pug)
environment.loaders.append('vue', vue)

environment.plugins.append(
  'VueLoaderPlugin',
  new VueLoaderPlugin()
)

environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader'
});

module.exports = environment
