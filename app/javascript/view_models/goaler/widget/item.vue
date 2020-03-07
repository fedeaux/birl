<template lang="pug">
  .goal-item
    .header
      .name {{ item.name }}

    .body(v-if='item.type')
      template(v-if='item.type == "yes-no"')
        .flex-row.ui.form
          .flex-item.grow-0
            .ui.basic.discret.tiny.green.button Yes
          .flex-item.grow-0
            .ui.basic.tiny.red.button No
          .flex-item.grow-3.ui.mini.input
            input(type='text')

      template(v-if='item.type == "timelog-track"')
        | 3.5 / 5 (70%)
</template>

<script lang="coffee">
  export default
    props: ['item']
</script>
