<template lang="pug">
  sui-modal(v-model="open")
    sui-modal-header(v-if='title') {{ title }}
    sui-modal-content
      slot
</template>

<script lang="coffee">
export default
  props:
    title: null

  data: ->
    open: true
</script>
