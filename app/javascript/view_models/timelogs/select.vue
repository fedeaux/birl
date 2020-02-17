<template lang="pug">
  shared-modal(v-if='form_timelog' title='New Timelog')
    timelogs-form(v-model='form_timelog'
                   @save='saveFormTimelog()'
                   @cancel='clearFormTimelog()')

  sui-dropdown(:options='timelogs_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Timelog'
               v-else
               v-model='selected_timelog_id')

</template>

<script lang="coffee">
import TimelogsManagerMixin from '../../mixins/timelogs/manager'

export default
  mixins: [TimelogsManagerMixin]

  model:
    prop: 'timelog_id'

  props:
    timelog_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_timelog_id: null

  methods:
    timelogAdded: (index, timelog) ->
      @selectTimelog timelog

    selectTimelog: (timelog) ->
      @selected_timelog_id = parseInt timelog.id

  computed:
    loading: ->
      !@timelogs

    timelogs_as_options: ->
      return [] unless @timelogs
      { key: timelog.id, value: timelog.id, text: timelog.name } for timelog in @timelogs

  watch:
    selected_timelog_id: ->
      selected_timelog_id = parseInt @selected_timelog_id

      unless isNaN selected_timelog_id
        @$emit 'input', selected_timelog_id
        return

      @newTimelog name: @selected_timelog_id

    timelog_id:
      immediate: true
      handler: ->
        return unless @timelog_id
        @selected_timelog_id = parseInt @timelog_id

</script>
