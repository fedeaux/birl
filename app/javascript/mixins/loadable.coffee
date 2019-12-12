export default
  methods:
    load: ->
      Global.events.$emit 'Global::StartLoading'

    loaded: ->
      Global.events.$emit 'Global::StopLoading'
