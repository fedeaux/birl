<template lang="pug">
.contexts-show-wrapper.flex-column.t-padded-2(v-if='context')
  .contexts-show.flex-item-fixed
    contexts-display(:context='context')
      shared-link.action-text(:to='context.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import ContextsResource from '../../resources/contexts_resource'

export default
  props:
    parent_context: null
    context_id:
      default: null

  data: ->
    context: null

  methods:
    loadContext: ->
      return unless @context_id
      @contexts_resource.get @context_id, @contextLoaded

    contextLoaded: (response) ->
      @context = response.context

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @context = @parent_context if @parent_context
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    context_id:
      immediate: true
      handler: ->
        @contexts_resource ?= new ContextsResource
        @loadContext()
</script>
