<template lang="pug">
.entity-form-wrapper.listers-form-wrapper.default-container(v-if='lister')
  .entity-form.listers-form
    .ui.form
      .field
        label Name
        input(type='text' v-model='lister.name')

      .field
        label Values
        listers-value-picker(v-model='lister.values')

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import ListersResource from '../../resources/listers_resource'
import Lister from '../../models/lister'

export default
  model:
    prop: 'original_lister'

  props:
    original_lister: null

  data: ->
    lister: null

  methods:
    save: ->
      @$emit 'input', @lister
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  watch:
    original_lister:
      immediate: true
      deep: true
      handler: ->
        if @original_lister
          @lister = @original_lister.clone()
        else
          @lister = null
</script>
