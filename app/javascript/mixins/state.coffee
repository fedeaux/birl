import ProfileResource from '../resources/profile_resource'
import User from '../models/user'

export default
  methods:
    setAudioSchema: (audio_schema) ->
      @$store.commit type: 'setAudioSchema', audio_schema: audio_schema

    setCurrentContext: (context) ->
      @$store.commit type: 'setCurrentContext', current_context: context

    setDevice: (device) ->
      @$store.commit type: 'setDevice', device: device

    setCurrentSession: (session) ->
      @$store.commit type: 'setCurrentSession', current_session: session

    setCurrentUser: (user) ->
      @$store.commit type: 'setCurrentUser', current_user: user

    updateContext: (context = null, callback = null) ->
      @current_user.current_context_id = context and context.id
      user = new User JSON.parse JSON.stringify @current_user
      @profile_resource.update user, @contextUpdatedClosure callback

      return unless context?.name == 'Bodybuilding'

      Global.player.event 'doit_finished', 'birl'

    contextUpdatedClosure: (callback) ->
      (response) =>
        @contextUpdated response, callback

    contextUpdated: (response, callback) ->
      @setCurrentUser response.user

      return callback() if callback
      return if @current_context

      @$router.push '/'

    setInitialUser: ->
      @setCurrentUser new User Global.server.user.user

  computed:
    audio_schema: ->
      @$store.state.audio_schema

    current_context: ->
      @$store.state.current_context

    current_session: ->
      @$store.state.current_session

    current_user: ->
      @$store.state.current_user

    device: ->
      @$store.state.device

    mobile: ->
      @$store.state.device == 'mobile'

    desktop: ->
      @$store.state.device == 'desktop'

  created: ->
    @profile_resource = new ProfileResource
