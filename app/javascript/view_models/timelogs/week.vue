<template lang="pug">
timelogs-range(:first_date='first_date'
               :last_date='last_date')
</template>

<script lang="coffee">
export default
  props:
    base_date:
      default: -> moment()

  computed:
    first_date: ->
      @base_date.clone().startOf('week')

    last_date: ->
      @base_date.clone().endOf('week')
</script>
