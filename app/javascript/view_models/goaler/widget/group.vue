<template lang="pug">
  .goal-group
    .goal-group-header {{ item.name }}
    goaler-widget-item(v-for='goal in item.goals' :item='goal')
</template>

<script lang="coffee">
  export default
    props: ['item']
</script>
