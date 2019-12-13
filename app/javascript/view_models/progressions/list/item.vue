<template lang="pug">
.entity-list-item-wrapper.progression-list-item-wrapper
  .entity-list-item-confirming-destroy(v-if='confirming_destroy && !showing_actions')
    .ui.four.column.grid
      .column
        .entity-list-item-confirming-destroy-message Are you sure?

      .column
        .ui.red.fluid.button(@click='$emit("destroy")') Destroy

      .column
        .ui.basic.fluid.button(@click='cancelDestroy()') Cancel

  .entity-list-item-actions(v-if='!confirming_destroy && showing_actions')
    .ui.four.column.grid
      .column(@click='$emit("edit")')
        router-link.ui.basic.fluid.green.icon.button(:to='progression.path()')
          i.eye.icon
          |  View

      .column(@click='$emit("edit")')
        .ui.basic.fluid.blue.icon.button
          i.edit.icon
          |  Edit

      .column(@click='confirmDestroy')
        .ui.basic.fluid.red.icon.button
          i.trash.icon
          |  Destroy

      .column(@click='hideActions()')
        .ui.basic.fluid.icon.button
          i.cancel.icon
          |  Cancel

  .entity-list-item.progression-list-item(v-if='!confirming_destroy && !showing_actions')
    progressions-list-item-contents(:progression='progression')

    .entity-list-item-actions-wrapper(v-if='allow_actions')
      i.ellipsis.vertical.icon(@click='showActions($event)')

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  data: ->
    showing_actions: false
    confirming_destroy: false

  props:
    progression:
      required: true

    allow_actions:
      default: false

  methods:
    confirmDestroy: ->
      @confirming_destroy = true
      @showing_actions = false

    cancelDestroy: ->
      @confirming_destroy = false

    showActions: ($event) ->
      @showing_actions = true
      @confirming_destroy = false
      $event.stopPropagation()

    hideActions: ->
      @showing_actions = false

</script>
