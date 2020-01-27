window.Vue = require('vue').default
window._ = require 'underscore'
window.$ = require 'jquery'
window.jQuery = window.$
window.moment = require 'moment'

import Database from 'lib/database'
import Player from 'lib/player'
import EntryGeneratorsMain from 'entry_generators/main'

window.Global =
  events: new Vue
  db: new Database
  vocabularies:
    kinds: ["adjective", "adverb", "noun", "preposition", "verb", "number", "phrase"]

require 'semantic-ui-sass'

import Session from '../models/session'
import routes from '../spa/routes'
import SuiVue from 'semantic-ui-vue'
Vue.use SuiVue

VueRouter = require('vue-router').default
Vue.use VueRouter

import LongPress from 'vue-directive-long-press'
Vue.directive 'long-press', LongPress

import Vuex from 'vuex'
Vue.use(Vuex)
store = new Vuex.Store(
  state:
    audio_schema: null
    current_context: null
    current_session: null
    current_user: null
    device: null
    global_loading: false

  mutations:
    setAudioSchema: (state, data) ->
      state.audio_schema = data.audio_schema
      Global.db.set 'audio_schema', state.audio_schema
      Global.player.setSchema data.audio_schema

    setCurrentUser: (state, data) ->
      state.current_user = data.current_user
      state.current_context = data.current_user.current_context

    setCurrentSession: (state, data) ->
      state.current_session = data.current_session
      Global.db.set 'current_session', state.current_session

    setDevice: (state, data) ->
      state.device = data.device

    setLoading: (state, data) ->
      state.global_loading = data.loading

  actions:
    setInitialState: (context) ->
      # Set audio schema
      context.commit 'setAudioSchema', audio_schema: Global.db.get 'audio_schema'

      # Load current session
      session_attributes = Global.db.get 'current_session'
      if session_attributes
        context.commit 'setCurrentSession', current_session: new Session session_attributes

      # Set dynamic css
      return unless Global.server.dynamic_css

      for rule in Global.server.dynamic_css
        sheet = window.document.styleSheets[0]
        sheet.insertRule rule, sheet.cssRules.length

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

import { Chrome } from 'vue-color'
Vue.component 'color-picker', Chrome

# for name, filter of Filters
#   Vue.filter name, filter

Global.initialize = ->
  if $('#birl-spa-container').length > 0
    Global.server = JSON.parse $('#server-json').text()
    Global.player = new Player Global.server.audio
    Global.egm = new EntryGeneratorsMain
    Global.egm.registerAll()

    router = new VueRouter routes: routes, mode: 'history'

    new Vue(
      router: router,
      store: store,
      render: (h) => h App,

      created: ->
        @$store.dispatch 'setInitialState'
        $(document).ajaxStart(@load).ajaxComplete(@loaded)
    ).$mount '#birl-spa-container'

unless location.protocol == 'file:'
  $ Global.initialize
