export default
  methods:
    load: ->
      @$store.dispatch 'setLoading', loading: true

    loaded: ->
      @$store.dispatch 'setLoading', loading: false

  computed:
    global_loading: ->
      @$store.state.global_loading
