import ProfileResource from '../resources/profile_resource'
import User from '../models/user'

export default
  methods:
    setAudioSchema: (audio_schema) ->
      @$store.commit type: 'setAudioSchema', audio_schema: audio_schema

    setCurrentContext: (context) ->
      @$store.commit type: 'setCurrentContext', current_context: context

    setCurrentSession: (session) ->
      @$store.commit type: 'setCurrentSession', current_session: session

    setCurrentUser: (user) ->
      @$store.commit type: 'setCurrentUser', current_user: user

    updateContext: (context = null) ->
      @current_user.current_context_id = context and context.id
      user = new User JSON.parse JSON.stringify @current_user
      @profile_resource.update user, @contextUpdated

      return unless context?.name == 'Bodybuilding'

      Global.player.event 'doit_finished', 'birl'

    contextUpdated: (response) ->
      @setCurrentUser response.user

      if @current_context
        @$router.push @current_context.meta and @current_context.meta.root or 'today'
      else
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

  created: ->
    @profile_resource = new ProfileResource
