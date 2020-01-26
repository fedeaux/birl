<template lang="pug">
.entity-show-wrapper.entries-show-wrapper.default-container(v-if='entry')
  .entity-show.entries-show
    entries-display(:entry='entry')
      router-link.entity-show-header-actions(:to='entry.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import EntriesResource from '../../resources/entries_resource'

export default
  props:
    parent_entry: null
    entry_id:
      default: null

  data: ->
    entry: null

  methods:
    loadEntry: ->
      return unless @entry_id
      @entries_resource.get @entry_id, @entryLoaded

    entryLoaded: (response) ->
      @entry = response.entry

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @entry = @parent_entry if @parent_entry
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    entry_id:
      immediate: true
      handler: ->
        @entries_resource ?= new EntriesResource
        @loadEntry()
</script>
