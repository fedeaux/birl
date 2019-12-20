<template lang="pug">
.entity-index.contexts-choose.default-container
  .choose-context-button-wrapper(v-for='context in contexts' @click='updateContext(context)')
    .ui.fluid.huge.button(:style='context.backgroundColor()')
      | {{ context.name }}
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
