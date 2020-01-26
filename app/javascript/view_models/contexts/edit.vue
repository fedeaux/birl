<template lang="pug">
.entity-edit.context-edit.default-container
  .entity-display
    .entity-display-main Edit Context

  contexts-form(v-model='context'
                v-if='context'
                @save='saveContext()'
                @cancel='contextDone()')
</template>

<script lang="coffee">

import ContextsResource from '../../resources/contexts_resource'
import Context from '../../models/context'

export default
  props:
    context_id:
      default: null

  data: ->
    context: null

  methods:
    loadContext: ->
      @contexts_resource.get @context_id, @contextLoaded

    contextLoaded: (response) ->
      @context = response.context

    saveContext: ->
      @contexts_resource.save @context, @contextDone

    contextDone: ->
      @$router.push @context.path()

  mounted: ->
    @contexts_resource = new ContextsResource
    @loadContext()
</script>
