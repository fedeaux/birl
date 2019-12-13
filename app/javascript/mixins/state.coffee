export default
  methods:
    setCurrentSession: (session) ->
      @$store.commit type: 'setCurrentSession', current_session: session

  computed:
    current_session: ->
      @$store.state.current_session
