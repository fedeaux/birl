<template lang="pug">
.entity-form-wrapper.vocabularies-form-wrapper.default-container(v-if='vocabulary')
  .entity-form.vocabularies-form
    .ui.form
      .field
        label Es
        input(type='text' v-model='vocabulary.es')

      .field
        label Pt Br
        input(type='text' v-model='vocabulary.pt_br')

      .field
        label Comment
        input(type='text' v-model='vocabulary.comment')

      .field
        label Kind
        sui-dropdown(:options='kinds_as_options'
                     :search='true'
                     :selection='true'
                     placeholder='Kind'
                     v-model='vocabulary.kind')

      .field
        label Meta

      .field.ui.fluid.buttons
        .ui.primary.button(@click='save()') Save
        .ui.basic.button(@click='cancel()') Cancel
</template>

<script lang="coffee">
import VocabulariesResource from '../../resources/vocabularies_resource'
import Vocabulary from '../../models/vocabulary'

export default
  model:
    prop: 'original_vocabulary'

  props:
    original_vocabulary: null

  data: ->
    vocabulary: null

  methods:
    save: ->
      @$emit 'input', @vocabulary
      @$emit 'save'

    cancel: ->
      @$emit 'cancel'

  computed:
    kinds_as_options: ->
      { key: kind, value: kind, text: kind } for kind in Global.vocabularies.kinds

  watch:
    original_vocabulary:
      immediate: true
      deep: true
      handler: ->
        if @original_vocabulary
          @vocabulary = @original_vocabulary.clone()
        else
          @vocabulary = null
</script>
