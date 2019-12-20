import ProfileResource from '../resources/profile_resource'
import User from '../models/user'

export default
  methods:
    setCurrentSession: (session) ->
      @$store.commit type: 'setCurrentSession', current_session: session

    setCurrentContext: (context) ->
      @$store.commit type: 'setCurrentContext', current_context: context

    setCurrentUser: (user) ->
      @$store.commit type: 'setCurrentUser', current_user: user

    updateContext: (context = null) ->
      @current_user.current_context_id = context and context.id
      user = new User JSON.parse JSON.stringify @current_user
      @profile_resource.update user, @contextUpdated

      return unless context?.name == 'Bodybuilding'

      Global.player.play 'porra', 'birl'

    contextUpdated: (response) ->
      @setCurrentUser response.user

      if @current_context
        @$router.push 'today'
      else
        @$router.push '/'

    setInitialUser: ->
      @setCurrentUser new User Global.server.user.user

  computed:
    current_context: ->
      @$store.state.current_context

    current_session: ->
      @$store.state.current_session

    current_user: ->
      @$store.state.current_user

  created: ->
    @profile_resource = new ProfileResource
