export default
  methods:
    load: ->
      console.log 'Global.events 1', Global.events
      Global.events.$emit 'Global::StartLoading'

    loaded: ->
      Global.events.$emit 'Global::StopLoading'
