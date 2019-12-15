<template lang="pug">
.entity-edit.context-edit.default-container
  contexts-form(v-model='context'
                v-if='context'
                @save='saveContext()'
                @cancel='contextDone()')
</template>

<script lang="coffee">

import ContextsResource from '../../resources/contexts_resource'
import Context from '../../models/context'

export default
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

  computed:
    context_id: ->
      @$route.params.id

  mounted: ->
    @contexts_resource = new ContextsResource
    @loadContext()
</script>
