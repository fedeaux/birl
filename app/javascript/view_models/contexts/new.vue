<template lang="pug">
.entity-new.context-new.default-container
  .entity-display
    .entity-display-main New Context

  contexts-form(v-model='context'
                @save='saveContext'
                @cancel='back')
</template>

<script lang="coffee">

import ContextsResource from '../../resources/contexts_resource'
import Context from '../../models/context'

export default
  data: ->
    context: new Context

  methods:
    saveContext: ->
      @contexts_resource.save @context, @saved

    saved: (data) ->
      @$router.push data.context.path()

    back: ->
      @$router.push @context.collectionPath()

  mounted: ->
    @contexts_resource = new ContextsResource
</script>
