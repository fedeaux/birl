<template lang="pug">
.entity-form-wrapper.memes-form-wrapper.default-container(v-if='meme')
  .entity-form.memes-form
    .ui.form
      .field
        label Type
        input(type='text' v-model='meme.type')

      .field
        label Contents

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import MemesResource from '../../resources/memes_resource'
import Meme from '../../models/meme'

export default
  model:
    prop: 'original_meme'

  props:
    original_meme: null

  data: ->
    meme: null

  methods:
    save: ->
      @$emit 'input', @meme
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_meme:
      immediate: true
      deep: true
      handler: ->
        if @original_meme
          @meme = @original_meme.clone()
        else
          @meme = null
</script>
