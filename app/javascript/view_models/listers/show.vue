<template lang="pug">
.entity-show-wrapper.listers-show-wrapper.default-container(v-if='lister')
  .entity-show.listers-show
    listers-display(:lister='lister')
      router-link.entity-show-header-actions(:to='lister.editPath()')
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

  data: ->
    lister: null
    lister_id: null

  methods:
    loadLister: ->
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
    '$route.params.id':
      immediate: true
      handler: ->
        @listers_resource ?= new ListersResource
        @lister_id = parseInt @$route.params.id
        @loadLister()
</script>
