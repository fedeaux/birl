<template lang="pug">
  shared-modal(v-if='form_lister' title='New Lister')
    listers-form(v-model='form_lister'
                   @save='saveFormLister()'
                   @cancel='clearFormLister()')

  sui-dropdown(:options='listers_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               :allowAdditions='allow_additions'
               placeholder='Lister'
               v-else
               v-model='selected_lister_id')

</template>

<script lang="coffee">
import ListersManagerMixin from '../../mixins/listers/manager'

export default
  mixins: [ListersManagerMixin]

  model:
    prop: 'lister_id'

  props:
    lister_id:
      default: null

    allow_additions:
      default: true

  data: ->
    selected_lister_id: null

  methods:
    listerAdded: (index, lister) ->
      @selectLister lister

    selectLister: (lister) ->
      @selected_lister_id = parseInt lister.id

  computed:
    loading: ->
      !@listers

    listers_as_options: ->
      return [] unless @listers
      { key: lister.id, value: lister.id, text: lister.name } for lister in @listers

  watch:
    selected_lister_id: ->
      selected_lister_id = parseInt @selected_lister_id

      unless isNaN selected_lister_id
        @$emit 'input', selected_lister_id
        return

      @newLister name: @selected_lister_id

    lister_id:
      immediate: true
      handler: ->
        return unless @lister_id
        @selected_lister_id = parseInt @lister_id

</script>
