import DaysResource from '../../resources/days_resource'
import Day from '../../models/day'

export default
  props:
    context:
      default: -> {}

    parent_days: null

  data: ->
    days: null
    form_day: null
    add_new: 'before'

  methods:
    dayAdded: (index, day) ->
      # console.log 'dayAdded', index, day

    getDay: (day_id) ->
      index = @dayIndex day_id
      return null if index == -1
      @days[index]

    editDay: (data) ->
      @setFormDay data.day

    destroyDay: (data) ->
      @days_resource.destroy data.day, @dayRemoved

    loadDays: ->
      @days_resource ?= new DaysResource

      if @parent_days
        @daysLoaded days: @parent_days
        return

      @days_resource.index @daysLoaded, @context

    daysLoaded: (response) ->
      @days = response.days

    buildDay: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Day final_params

    newDay: (params = {}) ->
      @setFormDay @buildDay params

    setFormDay: (@form_day) ->
      @form_day

    clearFormDay: ->
      @setFormDay null

    dayIndex: (day_id) ->
      for index, day of @days
        return index if day.id == day_id

      -1

    saveDay: (day, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @daySaved(data)
          custom_callback(data)

        @days_resource.save day, callback
        return

      @days_resource.save day, @daySaved

    saveFormDay: (custom_callback = false) ->
      @saveDay @form_day, custom_callback

    createDay: (attributes, custom_callback = false) ->
      @saveDay @buildDay(attributes), custom_callback

    addDay: (day) ->
      index = @dayIndex day.id

      if index == -1
        if @add_new == 'before'
          @days.unshift day
          index = 0
        else
          @days.push day
          index = @days.length - 1

      else
        Vue.set @days, index, day

      @dayAdded index, day

    daySaved: (data) ->
      @addDay data.day
      @clearFormDay()

    dayRemoved: (data) ->
      index = @dayIndex data.day.id
      return if index == -1
      @days.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadDays()
