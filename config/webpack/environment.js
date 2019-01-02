const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')
const coffee =  require('./loaders/coffee')

environment.loaders.append('coffee', coffee)
environment.loaders.append('vue', vue)

environment.loaders.get('sass').use.splice(-1, 0, {
    loader: 'resolve-url-loader'
});

module.exports = environment
