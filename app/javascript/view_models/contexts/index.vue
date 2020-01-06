<template lang="pug">
.entity-index.contexts-index.default-container
  contexts-manager(:parent_contexts='contexts')
</template>

<script lang="coffee">
import ContextsResource from '../../resources/contexts_resource'

export default
  data: ->
    contexts: null

  methods:
    loadContexts: ->
      @contexts_resource.index @contextsLoaded

    contextsLoaded: (response) ->
      @contexts = response.contexts

  mounted: ->
    @contexts_resource = new ContextsResource
    @loadContexts()
</script>
