import TimelogsResource from '../../resources/timelogs_resource'
import Timelog from '../../models/timelog'

export default
  props:
    context:
      default: -> {}

    parent_timelogs: null

  data: ->
    timelogs: null
    form_timelog: null
    add_new: 'before'

  methods:
    timelogAdded: (index, timelog) ->
      # console.log 'timelogAdded', index, timelog

    getTimelog: (timelog_id) ->
      index = @timelogIndex timelog_id
      return null if index == -1
      @timelogs[index]

    editTimelog: (data) ->
      @setFormTimelog data.timelog

    destroyTimelog: (data) ->
      @timelogs_resource.destroy data.timelog, @timelogRemoved

    loadTimelogs: ->
      @timelogs_resource ?= new TimelogsResource

      if @parent_timelogs
        @timelogsLoaded timelogs: @parent_timelogs
        return

      @timelogs_resource.index @timelogsLoaded, @context

    timelogsLoaded: (response) ->
      @timelogs = response.timelogs

    buildTimelog: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Timelog final_params

    newTimelog: (params = {}) ->
      @setFormTimelog @buildTimelog params

    setFormTimelog: (@form_timelog) ->
      @form_timelog

    clearFormTimelog: ->
      @setFormTimelog null

    timelogIndex: (timelog_id) ->
      for index, timelog of @timelogs
        return index if timelog.id == timelog_id

      -1

    saveTimelog: (timelog, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @timelogSaved(data)
          custom_callback(data)

        @timelogs_resource.save timelog, callback
        return

      @timelogs_resource.save timelog, @timelogSaved

    saveFormTimelog: (custom_callback = false) ->
      @saveTimelog @form_timelog, custom_callback

    createTimelog: (attributes, custom_callback = false) ->
      @saveTimelog @buildTimelog(attributes), custom_callback

    addTimelog: (timelog) ->
      index = @timelogIndex timelog.id

      if index == -1
        if @add_new == 'before'
          @timelogs.unshift timelog
          index = 0
        else
          @timelogs.push timelog
          index = @timelogs.length - 1

      else
        Vue.set @timelogs, index, timelog

      @timelogAdded index, timelog

    timelogSaved: (data) ->
      @addTimelog data.timelog
      @clearFormTimelog()

    timelogRemoved: (data) ->
      index = @timelogIndex data.timelog.id
      return if index == -1
      @timelogs.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadTimelogs()
