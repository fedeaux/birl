<template lang="pug">
  sui-dropdown(:options='contexts_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Context'
               v-model='selected_context_id')
</template>

<script lang="coffee">
import ContextsResource from '../../resources/contexts_resource'

export default
  model:
    prop: 'context_id'

  props:
    context_id: null

  data: ->
    contexts: null
    selected_context_id: null

  methods:
    loadContexts: ->
      @contexts_resource.index @contextsLoaded

    contextsLoaded: (response) ->
      @contexts = response.contexts

    contextIndex: (context_id) ->
      for index, context of @contexts
        return index if context.id == context_id

      -1

    getContext: (context_id) ->
      index = @contextIndex context_id
      return null if index == -1
      @contexts[index]

  computed:
    loading: ->
      !@contexts

    contexts_as_options: ->
      return [] unless @contexts
      { key: context.id, value: context.id, text: context.name } for context in @contexts

  watch:
    selected_context_id: ->
      @$emit 'input', @selected_context_id

    context_id:
      immediate: true
      handler: ->
        return unless @context_id
        @selected_context_id = parseInt @context_id

  mounted: ->
    @contexts_resource = new ContextsResource
    @loadContexts()

</script>
