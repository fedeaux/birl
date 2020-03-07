<template lang="pug">
  .goal-item
    .header
      .name {{ item.name }}

    .body(v-if='item.type')
      template(v-if='item.type == "yes-no"')
        .ui.three.buttons
          .ui.green.button Yes
          .ui.red.button No
      template(v-if='item.type == "timelog-track"')
        | 3.5 / 5 (70%)
</template>

<script lang="coffee">
  export default
    props: ['item']
</script>
