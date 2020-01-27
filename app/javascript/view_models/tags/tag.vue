<template lang="pug">
  shared-link.tags-tag(v-if='tag && linked' :style='style' :to='tag.path()')
    | {{ tag[display] }}
    slot

  .tags-tag(v-else-if='tag' :style='style')
    | {{ tag[display] }}
    slot
</template>

<script lang="coffee">
  export default
    props:
      display:
        default: 'name'

      tag:
        required: true

      linked:
        default: true

    data: ->
      style: {}

    methods:
      updateStyle: ->
        @style = {
          color: @tag.color and @tag.color.hex or '#fff'
          'background-color': @tag.background_color and @tag.background_color.hex or '#000'
        }

    watch:
      tag:
        deep: true
        immediate: true
        handler: ->
          @updateStyle()
</script>
