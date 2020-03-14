<template lang="pug">
.entity-list.training-list.default-container.flex-column
  .flex-item-fixed
    .entity-list-filter
      inputs-clearable.fluid(v-model='filter.text')

  .flex-item
    trainings-list-item(v-for='training in displayable_trainings'
                        v-if='trainings'
                        :training='training'
                        :allow_actions='allow_actions'
                        :key='training.id'
                        @edit='$emit("edit", { training: training })'
                        @destroy='$emit("destroy", { training: training })')

    entity-list-empty(v-if='!trainings || trainings.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    trainings:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (training) ->
      (@filter.text == '' or training.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_trainings: ->
      return [] unless @trainings

      (training for training in @trainings when @matchFilters training)
</script>
