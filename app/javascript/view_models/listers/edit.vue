<template lang="pug">
.entity-edit.lister-edit.default-container
  .entity-display
    .entity-display-main Edit Lister

  listers-form(v-model='lister'
               v-if='lister'
               @save='saveLister()'
               @cancel='listerDone()')
</template>

<script lang="coffee">

import ListersResource from '../../resources/listers_resource'
import Lister from '../../models/lister'

export default
  props:
    lister_id:
      default: null

  data: ->
    lister: null

  methods:
    loadLister: ->
      @listers_resource.get @lister_id, @listerLoaded

    listerLoaded: (response) ->
      @lister = response.lister

    saveLister: ->
      @listers_resource.save @lister, @listerDone

    listerDone: ->
      @$router.push @lister.path()

  mounted: ->
    @listers_resource = new ListersResource
    @loadLister()
</script>
