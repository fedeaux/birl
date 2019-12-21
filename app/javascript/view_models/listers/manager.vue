<template lang="pug">
.entity-manager.listers-manager.default-container
  .entity-manager-form(v-if='form_lister')
    listers-form(v-model='form_lister'
                 @save='saveFormLister()'
                 @cancel='clearFormLister()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-lister-button.ui.primary.top.attached.fluid.small.icon.button(@click='newLister')
        i.plus.icon
        |  Add

    listers-list(:listers='listers'
                 :allow_actions='true'
                 @edit='editLister($event)'
                 @destroy='destroyLister($event)')
</template>

<script lang="coffee">
import ListersResource from '../../resources/listers_resource'
import Lister from '../../models/lister'

export default
  props:
    context:
      default: -> {}

    parent_listers: null

  data: ->
    listers: null
    form_lister: null

  methods:
    editLister: (data) ->
      @setFormLister data.lister

    destroyLister: (data) ->
      @listers_resource.destroy data.lister, @listerRemoved

    loadListers: ->
      @listers_resource.index @listersLoaded, @context

    listersLoaded: (response) ->
      @listers = response.listers

    newLister: ->
      @setFormLister new Lister @context

    setFormLister: (@form_lister) ->

    clearFormLister: ->
      @setFormLister null

    listerIndex: (lister_id) ->
      for index, lister of @listers
        return index if lister.id == lister_id

      -1

    saveFormLister: ->
      @listers_resource.save @form_lister, @listerSaved

    addLister: (lister) ->
      index = @listerIndex lister.id

      if index == -1
        @listers.push lister
        return

      Vue.set @listers, index, lister

    listerSaved: (data) ->
      @addLister data.lister
      @clearFormLister()

    listerRemoved: (data) ->
      index = @listerIndex data.lister.id
      return if index == -1
      @listers.splice index, 1

  mounted: ->
    @listers_resource = new ListersResource

    if @parent_listers
      @listers = @parent_listers
      return

    @loadListers()
</script>
