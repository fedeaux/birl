<template lang="pug">
  .timeline-rule(v-if='at && start' :style='style()')
    | &nbsp;
</template>

<script lang="coffee">
  export default
    props: ['at', 'start']

    methods:
      style: ->
        { top: "#{moment.duration(@at.diff(@start)).asMinutes() + 10}px" }

</script>
