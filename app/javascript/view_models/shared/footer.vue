<template lang="pug">
  .shared-footer
    slot
</template>

<script lang="coffee">
export default
  methods:
    setContentPadding: ->
      @scrollableParent().css 'padding-bottom', "#{$(@$el).height() + 5}px"

    scrollableParent: ->
      # DUCT TAPE SAID HI
      return $('#contents-wrapper') if $(@$el).parents('#contents-wrapper').length > 0
      $('.entity-index')

  mounted: ->
    @setContentPadding()

  updated: ->
    @setContentPadding()

  beforeDestroy: ->
    @scrollableParent().css 'padding-bottom', 0
</script>
