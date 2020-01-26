<template lang="pug">
.entity-list-item-wrapper.entry-list-item-wrapper
  .entity-list-item-confirming-destroy(v-if='confirming_destroy && !showing_actions')
    .ui.four.column.grid
      .column
        .entity-list-item-confirming-destroy-message Are you sure?

      .column
        .ui.red.fluid.button(@click='$emit("destroy")') Yes

      .column
        .ui.basic.fluid.button(@click='cancelDestroy()') No

  .action-menu(v-if='!confirming_destroy && showing_actions')
    shared-link.action-menu-item(:to='entry.path()')
       i.eye.green.icon

    .action-menu-item(@click='$emit("edit")')
       i.edit.blue.icon

    .action-menu-item(@click='confirmDestroy')
       i.trash.red.icon

    .action-menu-item(@click='hideActions()')
       i.cancel.icon

  shared-link.entity-list-item.entry-list-item(v-if='!confirming_destroy && !showing_actions'
                                               :to='entry.path()')
    entries-display(:entry='entry'
                    :allow_actions='allow_actions'
                    @action='showActions')
      i.ellipsis.vertical.icon
</template>

<script lang="coffee">

export default
  props:
    entry:
      required: true

    allow_actions:
      default: false

  data: ->
    showing_actions: false
    confirming_destroy: false

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
