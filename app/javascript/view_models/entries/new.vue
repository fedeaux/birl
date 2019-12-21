<template lang="pug">
.entity-new.entry-new.default-container
  .entity-display
    .entity-display-main New Entry

  entries-form(v-model='entry'
               :data_model='entry.data_model'
               @save='saveEntry'
               @cancel='back')
</template>

<script lang="coffee">

import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  data: ->
    entry: new Entry

  methods:
    saveEntry: ->
      @entries_resource.save @entry, @saved

    saved: (data) ->
      @$router.push data.entry.path()

    back: ->
      @$router.push @entry.collectionPath()

  mounted: ->
    @entries_resource = new EntriesResource
</script>
