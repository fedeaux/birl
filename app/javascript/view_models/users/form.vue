<template lang="pug">
.entity-form-wrapper.users-form-wrapper.default-container(v-if='user')
  .entity-form.users-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='user.name')

      .field
        label Email
        input(type='text' v-model='user.email')

      .field
        label Current Context
        current_contexts-select(v-model='user.current_context_id')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import UsersResource from '../../resources/users_resource'
import User from '../../models/user'

export default
  model:
    prop: 'original_user'

  props:
    original_user: null

  data: ->
    user: null

  methods:
    save: ->
      @$emit 'input', @user
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_user:
      immediate: true
      deep: true
      handler: ->
        if @original_user
          @user = @original_user.clone()
        else
          @user = null
</script>
