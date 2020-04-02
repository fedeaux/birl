<template lang="pug">
  shared-modal(v-if='form_week' title='New Week')
    weeks-form(v-model='form_week'
                   @save='saveFormWeek()'
                   @cancel='clearFormWeek()')

  sui-dropdown(:options='weeks_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Week'
               v-else
               v-model='selected_week_id')

</template>

<script lang="coffee">
import WeeksManagerMixin from '../../mixins/weeks/manager'

export default
  mixins: [WeeksManagerMixin]

  model:
    prop: 'week_id'

  props:
    week_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_week_id: null

  methods:
    weekAdded: (index, week) ->
      @selectWeek week

    selectWeek: (week) ->
      @selected_week_id = parseInt week.id

  computed:
    loading: ->
      !@weeks

    weeks_as_options: ->
      return [] unless @weeks
      { key: week.id, value: week.id, text: week.name } for week in @weeks

  watch:
    selected_week_id: ->
      selected_week_id = parseInt @selected_week_id

      unless isNaN selected_week_id
        @$emit 'input', selected_week_id
        return

      @newWeek name: @selected_week_id

    week_id:
      immediate: true
      handler: ->
        return unless @week_id
        @selected_week_id = parseInt @week_id

</script>
