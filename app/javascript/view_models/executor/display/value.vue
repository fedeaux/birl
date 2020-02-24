<template lang="pug">
.executor-display-value(v-if='value')
  template(v-for='item in value')
    div(v-if='item.text')
      | {{ item.text }}

    pre.ascii_drawing(v-if='item.ascii_drawing')
      | {{ asciiDrawing(item) }}
</template>

<script lang="coffee">
  import AsciiDrawer from '../../../lib/ascii_drawer'

  export default
    props: ['value']

    computed:
      execution: ->
        'kkkk'

    methods:
      asciiDrawing: (item) ->
        (new AsciiDrawer(item)).draw()
</script>
