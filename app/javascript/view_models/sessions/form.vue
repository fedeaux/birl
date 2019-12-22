<template lang="pug">
.entity-form-wrapper.sessions-form-wrapper.default-container(v-if='session')
  .entity-form.sessions-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='session.name')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import SessionsResource from '../../resources/sessions_resource'
import Session from '../../models/session'

export default
  model:
    prop: 'original_session'

  props:
    original_session: null

  data: ->
    session: null

  methods:
    save: ->
      @$emit 'input', @session
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_session:
      immediate: true
      deep: true
      handler: ->
        if @original_session
          @session = @original_session.clone()
        else
          @session = null
</script>
