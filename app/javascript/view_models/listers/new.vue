<template lang="pug">
.entity-new.lister-new.default-container
  .entity-display
    .entity-display-main New Lister

  listers-form(v-model='lister'
               @save='saveLister'
               @cancel='back')
</template>

<script lang="coffee">

import ListersResource from '../../resources/listers_resource'
import Lister from '../../models/lister'

export default
  data: ->
    lister: new Lister

  methods:
    saveLister: ->
      @listers_resource.save @lister, @saved

    saved: (data) ->
      @$router.push data.lister.path()

    back: ->
      @$router.push @lister.collectionPath()

  mounted: ->
    @listers_resource = new ListersResource
</script>
