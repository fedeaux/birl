<template lang="pug">
  .goal-item
    .header
      .name {{ item.name }}

    .body(v-if='item.type')
      template(v-if='item.type == "YesOrNoGoal"')
        .flex-row.ui.form
          .flex-item.grow-0
            .ui.basic.discret.tiny.green.button Yes
          .flex-item.grow-0
            .ui.basic.tiny.red.button No
          .flex-item.grow-3.ui.mini.input
            input(type='text', v-model='item.meta.text')

      template(v-if='item.type == "TimelogGoal"')
        | {{ item.meta.duration_as_minutes }} / {{ item.meta.target_duration }} ({{ item.meta.completeness }})
</template>

<script lang="coffee">
  # "item" can be either a... can... ? Oh fuck it

  export default
    props: ['item']

    created: ->
</script>
