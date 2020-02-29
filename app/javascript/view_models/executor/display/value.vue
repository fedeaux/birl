<template lang="pug">
.executor-display-value(v-if='value')
  template(v-for='item in value')
    a(v-if='item.link'
      target='blank'
      :href='item.link')
      | link

    div(v-if='item.text')
      | {{ item.text }}

    pre.ascii_drawing(v-if='item.ascii_drawing')
      | {{ asciiDrawing(item) }}
</template>

<script lang="coffee">
  import AsciiDrawer from '../../../lib/ascii_drawer'

  export default
    props: ['value']

    methods:
      asciiDrawing: (item) ->
        (new AsciiDrawer(item)).draw()
</script>
