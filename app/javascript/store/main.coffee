import Vue from 'vue'
import Vuex from 'vuex'
import Session from '../models/session'

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

export default store
