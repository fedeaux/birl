<template lang="pug">
  shared-modal(v-if='form_context' title='New Context')
    contexts-form(v-model='form_context'
                   @save='saveFormContext()'
                   @cancel='clearFormContext()')

  sui-dropdown(:options='contexts_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Context'
               v-else
               v-model='selected_context_id')

</template>

<script lang="coffee">
import ContextsManagerMixin from '../../mixins/contexts/manager'

export default
  mixins: [ContextsManagerMixin]

  model:
    prop: 'context_id'

  props:
    context_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_context_id: null

  methods:
    contextAdded: (index, context) ->
      @selectContext context

    selectContext: (context) ->
      @selected_context_id = parseInt context.id

  computed:
    loading: ->
      !@contexts

    contexts_as_options: ->
      return [] unless @contexts
      { key: context.id, value: context.id, text: context.name } for context in @contexts

  watch:
    selected_context_id: ->
      selected_context_id = parseInt @selected_context_id

      unless isNaN selected_context_id
        @$emit 'input', selected_context_id
        return

      @newContext name: @selected_context_id

    context_id:
      immediate: true
      handler: ->
        return unless @context_id
        @selected_context_id = parseInt @context_id

</script>
