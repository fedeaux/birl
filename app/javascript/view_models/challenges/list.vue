<template lang="pug">
.entity-list.challenge-list.default-container
  challenges-list-item(v-for='challenge in challenges'
                       v-if='challenges'
                       :challenge='challenge'
                       :allow_actions='allow_actions'
                       :key='challenge.id'
                       @edit='$emit("edit", { challenge: challenge })'
                       @destroy='$emit("destroy", { challenge: challenge })')

  entity-list-empty(v-if='!challenges || challenges.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    challenges:
      default: null
</script>
