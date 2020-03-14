<template lang="pug">
.entity-list.lister-list.default-container.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item
    listers-list-item(v-for='lister in displayable_listers'
                      v-if='listers'
                      :lister='lister'
                      :allow_actions='allow_actions'
                      :key='lister.id'
                      @edit='$emit("edit", { lister: lister })'
                      @destroy='$emit("destroy", { lister: lister })')

    entity-list-empty(v-if='!listers || listers.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    listers:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (lister) ->
      (@filter.text == '' or lister.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_listers: ->
      return [] unless @listers

      (lister for lister in @listers when @matchFilters lister)
</script>
