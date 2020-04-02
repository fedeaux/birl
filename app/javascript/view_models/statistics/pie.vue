<template lang="pug">
.statistics-pie
  apexchart(type='donut' width='380' :options='options' :series='series')
</template>

<script lang="coffee">
export default
  props: ['statiscable', 'base']

  methods:
    barStyle: (item) ->
      width = (item.values.duration * 100 / @base) + '%'

      {
        color: item.tag.color.hex
        'background-color': item.tag.background_color.hex
        width: width
      }

  computed:
    items: ->
      @statiscable.meta.statistics.timelogs.sort (a, b) -> b.values.duration - a.values.duration

    durations: ->
      (item.values.duration for item in @items)

    total_duration: ->
      @durations.reduce ((duration, sum) -> duration + sum)

    series: ->
      @durations.concat [@base - @total_duration]

    labels: ->
      (item.tag.fullname for item in @items).concat ['uncharted']

    colors: ->
      (item.tag.background_color.hex for item in @items).concat ['#FFF']

    options: ->
      chart:
        width: 380

      labels: @labels

      colors: @colors

      responsive: [ {
        breakpoint: 480
        options:
          chart: width: 200
          legend: position: 'bottom'
      } ]

</script>
