window.Vue = require('vue').default
window._ = require 'underscore'
window.$ = require 'jquery'
window.jQuery = window.$
window.moment = require 'moment'

require 'semantic-ui-sass'

import routes from '../spa/routes'
import SuiVue from 'semantic-ui-vue'
Vue.use SuiVue

VueRouter = require('vue-router').default
Vue.use VueRouter

import App from '../view_models/app'

import view_model_paths from '../spa/view_model_paths'

view_model_aliases = {
}

for view_model_path in view_model_paths.paths
  main_component_name = view_model_path.replace(/\//g, '-').replace /_/g, '-'
  component = require("view_models/#{view_model_path}").default

  # register the component by its main name and aliases
  for component_name in (view_model_aliases[main_component_name] or []).concat [main_component_name]
    Vue.component component_name, component

# for name, filter of Filters
#   Vue.filter name, filter

$ ->
  if $('#birl-spa-container').length > 0
    router = new VueRouter routes: routes, mode: 'history'

    new Vue(
      router: router,
      render: (h) => h App
    ).$mount '#birl-spa-container'
