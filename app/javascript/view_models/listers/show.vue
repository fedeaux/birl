<template lang="pug">
.listers-show-wrapper.flex-column.t-padded-2(v-if='lister')
  .listers-show.flex-item-fixed
    listers-display(:lister='lister')
      shared-link.action-text(:to='lister.editPath()')
        i.edit.icon

  //- BrainDamage: Body Start
  .entity-list.lister-list.default-container
    .entity-list-item-wrapper.lister-list-item-wrapper
       .entity-list-item.lister-list-item(v-for='item in lister.values.items')
         .entity-display
           .entity-display-main
             | {{ item }}
  //- BrainDamage: Body End
</template>

<script lang="coffee">
import ListersResource from '../../resources/listers_resource'

export default
  props:
    parent_lister: null
    lister_id:
      default: null

  data: ->
    lister: null

  methods:
    loadLister: ->
      return unless @lister_id
      @listers_resource.get @lister_id, @listerLoaded

    listerLoaded: (response) ->
      @lister = response.lister

    # BrainDamage: Methods Start
    # BrainDamage: Methods End

  mounted: ->
    @lister = @parent_lister if @parent_lister
    # BrainDamage: Mounted Start
    # BrainDamage: Mounted End

  watch:
    lister_id:
      immediate: true
      handler: ->
        @listers_resource ?= new ListersResource
        @loadLister()
</script>
