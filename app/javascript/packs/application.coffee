window.Vue = require('vue').default
window._ = require 'underscore'
window.$ = require 'jquery'
window.jQuery = window.$

import Moment from 'moment'
import { extendMoment } from 'moment-range';
window.moment = extendMoment(Moment)

import Database from 'lib/database'
import Player from 'lib/player'
import EntryGeneratorsMain from 'entry_generators/main'

window.Global =
  events: new Vue
  db: new Database
  vocabularies:
    kinds: ["adjective", "adverb", "noun", "preposition", "verb", "number", "phrase"]

require 'semantic-ui-sass'

import routes from '../spa/routes'
import SuiVue from 'semantic-ui-vue'
Vue.use SuiVue

VueRouter = require('vue-router').default
Vue.use VueRouter

import LongPress from 'vue-directive-long-press'
Vue.directive 'long-press', LongPress

import App from '../view_models/app'
import LoadableMixin from '../mixins/loadable'
import StateMixin from '../mixins/state'

import store from '../store/main'
import view_model_paths from '../spa/view_model_paths'

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

import VueApexCharts from 'vue-apexcharts'
Vue.component 'apexchart', VueApexCharts

import filters from '../spa/filters'

for name, filter of filters
  Vue.filter name, filter

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
