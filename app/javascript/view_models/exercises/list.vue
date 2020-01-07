<template lang="pug">
.entity-list.exercise-list.default-container
  .entity-list-filter
    inputs-clearable.fluid(v-model='filter.text')

  exercises-list-item(v-for='exercise in displayable_exercises'
                      v-if='exercises'
                      :exercise='exercise'
                      :allow_actions='allow_actions'
                      :key='exercise.id'
                      @edit='$emit("edit", { exercise: exercise })'
                      @destroy='$emit("destroy", { exercise: exercise })')

  entity-list-empty(v-if='!exercises || exercises.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    exercises:
      default: null

  data: ->
    filter:
      text: ''

  methods:
    matchFilters: (exercise) ->
      (@filter.text == '' or exercise.name.toLowerCase().indexOf(@filter.text.toLowerCase()) != -1)

  computed:
    displayable_exercises: ->
      return [] unless @exercises

      (exercise for exercise in @exercises when @matchFilters exercise)
</script>
