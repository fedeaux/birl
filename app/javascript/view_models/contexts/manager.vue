<template lang="pug">
.entity-manager.contexts-manager.default-container
  .entity-manager-form(v-if='form_context')
    contexts-form(v-model='form_context'
                  @save='saveFormContext()'
                  @cancel='clearFormContext()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-context-button.ui.primary.top.attached.fluid.small.icon.button(@click='newContext')
        i.plus.icon
        |  Add

    contexts-list(:contexts='contexts'
                  :allow_actions='true'
                  @edit='editContext($event)'
                  @destroy='destroyContext($event)')
</template>

<script lang="coffee">
import ContextsResource from '../../resources/contexts_resource'
import Context from '../../models/context'

export default
  props:
    context:
      default: -> {}

    parent_contexts: null

  data: ->
    contexts: null
    form_context: null

  methods:
    editContext: (data) ->
      @setFormContext data.context

    destroyContext: (data) ->
      @contexts_resource.destroy data.context, @contextRemoved

    loadContexts: ->
      @contexts_resource.index @contextsLoaded, @context

    contextsLoaded: (response) ->
      @contexts = response.contexts

    newContext: ->
      @setFormContext new Context @context

    setFormContext: (@form_context) ->

    clearFormContext: ->
      @setFormContext null

    contextIndex: (context_id) ->
      for index, context of @contexts
        return index if context.id == context_id

      -1

    saveFormContext: ->
      @contexts_resource.save @form_context, @contextSaved

    addContext: (context) ->
      index = @contextIndex context.id

      if index == -1
        @contexts.push context
        return

      Vue.set @contexts, index, context

    contextSaved: (data) ->
      @addContext data.context
      @clearFormContext()

    contextRemoved: (data) ->
      index = @contextIndex data.context.id
      return if index == -1
      @contexts.splice index, 1

  mounted: ->
    @contexts_resource = new ContextsResource

    if @parent_contexts
      @contexts = @parent_contexts
      return

    @loadContexts()
</script>
