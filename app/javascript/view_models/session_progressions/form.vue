<template lang="pug">
.entity-form-wrapper.session_progressions-form-wrapper.default-container(v-if='session_progression')
  .entity-form.session_progressions-form
    .ui.form
      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel

</template>

<script lang="coffee">
import SessionProgressionsResource from '../../resources/session_progressions_resource'
import SessionProgression from '../../models/session_progression'

export default
  model:
    prop: 'original_session_progression'

  props:
    original_session_progression: null

  data: ->
    session_progression: null

  methods:
    save: ->
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  mounted: ->

  watch:
    original_session_progression:
      immediate: true
      deep: true
      handler: ->
        if @original_session_progression
          @session_progression = @original_session_progression.clone()
        else
          @session_progression = null
</script>
