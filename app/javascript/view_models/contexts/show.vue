<template lang="pug">
.entity-show-wrapper.contexts-show-wrapper.default-container(v-if='context')
  .entity-show.contexts-show
    contexts-display(:context='context')
      router-link.entity-show-header-actions(:to='context.editPath()')
        i.edit.icon
</template>

<script lang="coffee">
import ContextsResource from '../../resources/contexts_resource'

export default
  props:
    parent_context: null

  data: ->
    context: null
    context_id: null

  methods:
    loadContext: ->
      @contexts_resource.get @context_id, @contextLoaded

    contextLoaded: (response) ->
      @context = response.context

  mounted: ->
    if @parent_context
      @context = @parent_context
      return

    @contexts_resource = new ContextsResource
    @context_id = @$route.params.id
    @loadContext()
</script>
