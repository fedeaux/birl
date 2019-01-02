window.Vue = require('vue').default
window._ = require 'underscore'
window.$ = require 'jquery'
window.jQuery = window.$
window.moment = require 'moment'

import routes from '../spa/routes'
import SuiVue from 'semantic-ui-vue'
Vue.use SuiVue
VueRouter = require('vue-router').default

import App from '../view_models/app'

$ ->
  console.log "Vai tomar no cu"
  if $('#birl-spa-container').length > 0
    router = new VueRouter routes: routes, mode: 'history'

    new Vue(
      router: router,
      render: (h) => h App
    ).$mount '#birl-spa-container'
