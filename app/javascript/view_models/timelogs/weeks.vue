<template lang="pug">
.timelogs-weeks.scroll-y
  timelogs-week(v-for='date in horizontal_dates'
                v-if='display == "horizontal"'
                :base_date='date'
                style='height: 520px')

  .timelogs-weeks-vertical
    .flex-row.timelogs-weeks-vertical-weekday(v-for='date_group in vertical_dates_groups' style='height: 520px')
      timelogs-today.flex-item(v-for='date in date_group'
                               :header='"simple"'
                               :override_base_date='date'
                               :show_steps_times='show_steps_times'
                               :minutes_per_step='minutes_per_step')
</template>

<script lang="coffee">
export default
  props:
    base_date:
      default: -> moment('2020-02-18')

  data: ->
    display: 'vertical'
    minutes_per_step: 30
    show_steps_times: false

  computed:
    horizontal_dates: ->
      current_date = @base_date.clone()
      dates = []

      while current_date.isBefore(moment())
        dates.push current_date.clone()
        current_date.add 1, 'week'

      dates

    vertical_dates_groups: ->
      current_date = @base_date.clone().startOf 'week'
      max_date = moment().endOf 'week'
      date_groups = [[], [], [], [], [], [], []]

      console.log @base_date, current_date.format(), max_date.format()

      while current_date.isBefore(max_date)
        date_groups[current_date.day()].push current_date.clone()
        current_date.add 1, 'day'
        console.log 'date_groups', date_groups

      date_groups

    last_date: ->
      @base_date.clone().endOf('week')
</script>
