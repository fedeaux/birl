<template lang="pug">
listers-manager.listers-index(:parent_listers='listers')
</template>

<script lang="coffee">
import ListersResource from '../../resources/listers_resource'

export default
  data: ->
    listers: null

  methods:
    loadListers: ->
      @listers_resource.index @listersLoaded

    listersLoaded: (response) ->
      @listers = response.listers

  mounted: ->
    @listers_resource = new ListersResource
    @loadListers()
</script>
