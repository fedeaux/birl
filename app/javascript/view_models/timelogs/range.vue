<template lang="pug">
.timelogs-range.scroll-y.flex-row
  timelogs-today.flex-item(v-for='date in dates'
                           :header='"simple"'
                           :override_base_date='date'
                           :show_steps_times='show_steps_times'
                           :minutes_per_step='minutes_per_step')
</template>

<script lang="coffee">
export default
  props:
    minutes_per_step:
      default: 30

    first_date:
      required: true

    last_date:
      required: true

    show_steps_times:
      default: false

  computed:
    dates: ->
      current_date = @first_date
      dates = []

      while current_date.format('YY-MM-DD') != @last_date.format('YY-MM-DD')
        dates.push current_date
        current_date = current_date.clone().add 1, 'day'

      dates.push @last_date.clone()
      dates

</script>
