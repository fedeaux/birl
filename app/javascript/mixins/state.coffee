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

    updateContext: (context_id = null) ->
      @current_user.current_context_id = context_id
      user = new User JSON.parse JSON.stringify @current_user
      @profile_resource.update user, @contextUpdated

    contextUpdated: (response) ->
      @setCurrentUser response.user

      if @current_context
        @$router.push 'today'
      else
        @$router.push '/'

    setInitialUser: ->
      @setCurrentUser new User JSON.parse($('#server-json').text()).user

  computed:
    current_context: ->
      @$store.state.current_context

    current_session: ->
      @$store.state.current_session

    current_user: ->
      @$store.state.current_user

  created: ->
    @profile_resource = new ProfileResource
