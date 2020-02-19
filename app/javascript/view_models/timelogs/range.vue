<template lang="pug">
.timelogs-range
  .timelogs-range-day(v-for='date in dates')
    timelogs-today(:base_date='date')
</template>

<script lang="coffee">
export default
  props:
    first_date:
      required: true

    last_date:
      required: true

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
