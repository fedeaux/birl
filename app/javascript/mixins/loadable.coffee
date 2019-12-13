export default
  methods:
    load: ->
      @$store.dispatch 'setLoading', loading: true

    loaded: ->
      @$store.dispatch 'setLoading', loading: false

  computed:
    loading: ->
      @$store.state.loading
