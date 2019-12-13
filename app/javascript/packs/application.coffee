window.Vue = require('vue').default
window._ = require 'underscore'
window.$ = require 'jquery'
window.jQuery = window.$
window.moment = require 'moment'

import Database from 'lib/database'

window.Global =
  events: new Vue
  db: new Database

require 'semantic-ui-sass'

import Session from '../models/session'
import routes from '../spa/routes'
import SuiVue from 'semantic-ui-vue'
Vue.use SuiVue

VueRouter = require('vue-router').default
Vue.use VueRouter

import Vuex from 'vuex'
Vue.use(Vuex)
store = new Vuex.Store(
  state:
    current_session: null
    global_loading: false

  mutations:
    setCurrentSession: (state, data) ->
      state.current_session = data.current_session
      Global.db.set 'current_session', state.current_session

    setLoading: (state, data) ->
      state.global_loading = data.loading

  actions:
    loadCurrentSession: (context) ->
      session_attributes = Global.db.get 'current_session'
      if session_attributes
        context.commit 'setCurrentSession', current_session: new Session session_attributes

    setLoading: (context, data) ->
      context.commit 'setLoading', data
)

import App from '../view_models/app'
import view_model_paths from '../spa/view_model_paths'
import LoadableMixin from '../mixins/loadable'
import StateMixin from '../mixins/state'

Vue.mixin LoadableMixin
Vue.mixin StateMixin

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
      store: store,
      render: (h) => h App,
      created: ->
        @$store.dispatch 'loadCurrentSession'
        $(document).ajaxStart(@load).ajaxComplete(@loaded)

    ).$mount '#birl-spa-container'
