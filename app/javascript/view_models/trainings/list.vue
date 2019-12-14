<template lang="pug">
.entity-list.training-list.default-container
  trainings-list-item(v-for='training in trainings'
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
</script>
