<template lang="pug">
  .shared-footer
    slot
</template>

<script lang="coffee">
export default
  methods:
    setContentPadding: ->
      $('#contents-wrapper').css 'padding-bottom', "#{$(@$el).height()}px"

  mounted: ->
    @setContentPadding()

  updated: ->
    @setContentPadding()

  beforeDestroy: ->
    $('#contents-wrapper').css 'padding-bottom', 0
</script>
