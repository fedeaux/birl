<template lang="pug">
  sui-dropdown(:options='listers_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='Lister'
               v-model='selected_lister_id')
</template>

<script lang="coffee">
import ListersResource from '../../resources/listers_resource'

export default
  model:
    prop: 'lister_id'

  props:
    lister_id: null

  data: ->
    listers: null
    selected_lister_id: null

  methods:
    loadListers: ->
      @listers_resource.index @listersLoaded

    listersLoaded: (response) ->
      @listers = response.listers

    listerIndex: (lister_id) ->
      for index, lister of @listers
        return index if lister.id == lister_id

      -1

    getLister: (lister_id) ->
      index = @listerIndex lister_id
      return null if index == -1
      @listers[index]

  computed:
    loading: ->
      !@listers

    listers_as_options: ->
      return [] unless @listers
      { key: lister.id, value: lister.id, text: lister.name } for lister in @listers

  watch:
    selected_lister_id: ->
      @$emit 'input', @selected_lister_id

    lister_id:
      immediate: true
      handler: ->
        return unless @lister_id
        @selected_lister_id = parseInt @lister_id

  mounted: ->
    @listers_resource = new ListersResource
    @loadListers()

</script>
