<template lang="pug">
.tags-tag(v-if="tag" :style='style')
  | {{ tag.name }}
</template>

<script lang="coffee">
  export default
    props:
      tag:
        required: true

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
