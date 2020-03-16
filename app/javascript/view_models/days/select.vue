<template lang="pug">
  shared-modal(v-if='form_day' title='New Day')
    days-form(v-model='form_day'
                   @save='saveFormDay()'
                   @cancel='clearFormDay()')

  sui-dropdown(:options='days_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Day'
               v-else
               v-model='selected_day_id')

</template>

<script lang="coffee">
import DaysManagerMixin from '../../mixins/days/manager'

export default
  mixins: [DaysManagerMixin]

  model:
    prop: 'day_id'

  props:
    day_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_day_id: null

  methods:
    dayAdded: (index, day) ->
      @selectDay day

    selectDay: (day) ->
      @selected_day_id = parseInt day.id

  computed:
    loading: ->
      !@days

    days_as_options: ->
      return [] unless @days
      { key: day.id, value: day.id, text: day.name } for day in @days

  watch:
    selected_day_id: ->
      selected_day_id = parseInt @selected_day_id

      unless isNaN selected_day_id
        @$emit 'input', selected_day_id
        return

      @newDay name: @selected_day_id

    day_id:
      immediate: true
      handler: ->
        return unless @day_id
        @selected_day_id = parseInt @day_id

</script>
