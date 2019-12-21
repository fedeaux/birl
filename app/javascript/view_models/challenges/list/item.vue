<template lang="pug">
.entity-list-item-wrapper.challenge-list-item-wrapper
  .entity-list-item-confirming-destroy(v-if='confirming_destroy && !showing_actions')
    .ui.four.column.grid
      .column
        .entity-list-item-confirming-destroy-message Are you sure?

      .column
        .ui.red.fluid.button(@click='$emit("destroy")') Yes

      .column
        .ui.basic.fluid.button(@click='cancelDestroy()') No

  .entity-list-item-actions(v-if='!confirming_destroy && showing_actions')
    .ui.four.column.grid
      .column(@click='$emit("edit")')
        router-link.ui.basic.fluid.green.icon.button(:to='challenge.path()')
          i.eye.icon

      .column(@click='$emit("edit")')
        .ui.basic.fluid.blue.icon.button
          i.edit.icon

      .column(@click='confirmDestroy')
        .ui.basic.fluid.red.icon.button
          i.trash.icon

      .column(@click='hideActions()')
        .ui.basic.fluid.icon.button
          i.cancel.icon

  router-link.entity-list-item.challenge-list-item(v-if='!confirming_destroy && !showing_actions'
                                                   :to='challenge.path()')
    challenges-display(:challenge='challenge'
                       :allow_actions='allow_actions'
                       @action='showActions')
      i.ellipsis.vertical.icon

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  data: ->
    showing_actions: false
    confirming_destroy: false

  props:
    challenge:
      required: true

    allow_actions:
      default: false

  methods:
    confirmDestroy: ->
      @confirming_destroy = true
      @showing_actions = false

    cancelDestroy: ->
      @confirming_destroy = false

    showActions: ->
      @showing_actions = true
      @confirming_destroy = false

    hideActions: ->
      @showing_actions = false

</script>
