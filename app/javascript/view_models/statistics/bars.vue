<template lang="pug">
.statistics-bars
  apexchart(type='bar' :options='options' :series='series')
</template>

<script lang="coffee">
export default
  props: ['statiscables', 'base']

  computed:
    series: ->
      computed_series = {}

      for statiscable in @statiscables
        for item in statiscable.meta.statistics.timelogs
          computed_series[item.tag.id] ||= {
            name: item.tag.fullname
            color: item.tag.background_color.hex
            data: []
          }

      expected_length = 0
      for statiscable in @statiscables
        for item in statiscable.meta.statistics.timelogs
          computed_series[item.tag.id].data.push item.values.mean_duration_by_day

        expected_length += 1

        for tag_id, _ of computed_series
          if computed_series[tag_id].data.length < expected_length
            computed_series[tag_id].data.push 0

      Object.values(computed_series)

    options: ->
      colors: (item.color for item in @series)

      chart:
        type: 'bar'
        height: 350
        stacked: true
        toolbar: show: true
        zoom: enabled: true

      responsive: [ {
        breakpoint: 480
        options: legend:
          position: 'bottom'
          offsetX: -10
          offsetY: 0
      } ]
      plotOptions:
        bar:
          horizontal: false

      xaxis:
        categories: (statiscable.name for statiscable in @statiscables)

      legend:
        position: 'right'
        offsetY: 40

      dataLabels:
        formatter: (value, meta) =>
          # console.log @series[meta.dataPointIndex]
          "#{Math.round(value/60/60)}h"

      fill: opacity: 1
</script>
