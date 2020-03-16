<template lang="pug">
.statistics-line.flex-row
  .statistics-line-label.flex-item-fixed
    | {{ day.name }}
  .statistics-line-bars.flex-item
    .statistics-line-bar.center-aligned(v-for='item in items' :style='barStyle(item)')
      | {{ item.tag.fullname }}
</template>

<script lang="coffee">
export default
  props: ['day', 'base']

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
      @day.meta.statistics.timelogs.sort (a, b) -> b.values.duration - a.values.duration
</script>
