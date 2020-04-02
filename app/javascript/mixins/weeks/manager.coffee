import WeeksResource from '../../resources/weeks_resource'
import Week from '../../models/week'

export default
  props:
    context:
      default: -> {}

    parent_weeks: null

  data: ->
    weeks: null
    form_week: null
    add_new: 'before'

  methods:
    weekAdded: (index, week) ->
      # console.log 'weekAdded', index, week

    getWeek: (week_id) ->
      index = @weekIndex week_id
      return null if index == -1
      @weeks[index]

    editWeek: (data) ->
      @setFormWeek data.week

    destroyWeek: (data) ->
      @weeks_resource.destroy data.week, @weekRemoved

    loadWeeks: ->
      @weeks_resource ?= new WeeksResource

      if @parent_weeks
        @weeksLoaded weeks: @parent_weeks
        return

      @weeks_resource.index @weeksLoaded, @context

    weeksLoaded: (response) ->
      @weeks = response.weeks

    buildWeek: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Week final_params

    newWeek: (params = {}) ->
      @setFormWeek @buildWeek params

    setFormWeek: (@form_week) ->
      @form_week

    clearFormWeek: ->
      @setFormWeek null

    weekIndex: (week_id) ->
      for index, week of @weeks
        return index if week.id == week_id

      -1

    saveWeek: (week, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @weekSaved(data)
          custom_callback(data)

        @weeks_resource.save week, callback
        return

      @weeks_resource.save week, @weekSaved

    saveFormWeek: (custom_callback = false) ->
      @saveWeek @form_week, custom_callback

    createWeek: (attributes, custom_callback = false) ->
      @saveWeek @buildWeek(attributes), custom_callback

    addWeek: (week) ->
      index = @weekIndex week.id

      if index == -1
        if @add_new == 'before'
          @weeks.unshift week
          index = 0
        else
          @weeks.push week
          index = @weeks.length - 1

      else
        Vue.set @weeks, index, week

      @weekAdded index, week

    weekSaved: (data) ->
      @addWeek data.week
      @clearFormWeek()

    weekRemoved: (data) ->
      index = @weekIndex data.week.id
      return if index == -1
      @weeks.splice index, 1

  watch:
    context:
      immediate: true
      handler: ->
        @loadWeeks()
