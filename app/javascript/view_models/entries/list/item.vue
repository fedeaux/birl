<template lang="pug">
.entity-list-item-wrapper.entry-list-item-wrapper
  .entity-list-item-confirming-destroy(v-if='confirming_destroy')
    .ui.red.message
      .centered Confirm destroy?

    .ui.small.fluid.buttons
      .ui.red.button(@click='$emit("destroy")') Destroy
      .ui.basic.button(@click='cancelDestroy()') Cancel

  .entity-list-item.entry-list-item(v-else)
    .entry-list-item-date {{ entry.created_at.fromNow() }}
    .entry-list-item-values {{ entry.values }}
    .entry-list-item-variables {{ entry.variables }}

    .entity-list-item-actions-wrapper
      i.ellipsis.vertical.icon(@click='showActions($event)' v-if='!show_actions')

      .ui.vertical.text.menu.entity-list-item-actions(v-if='show_actions')
        .item(@click='$emit("edit")')
          | Edit
          i.edit.icon
        .item(@click='confirmDestroy()')
          | Destroy
          i.trash.icon

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  data: ->
    show_actions: false
    confirming_destroy: false

  props:
    entry:
      required: true

  methods:
    confirmDestroy: ->
      @confirming_destroy = true

    cancelDestroy: ->
      @confirming_destroy = false

    showActions: ($event) ->
      @show_actions = true
      $event.stopPropagation()

    hideActions: ->
      @show_actions = false

  mounted: ->
    $(document).on 'click', @hideActions

  beforeDestroy: ->
    $(document).off 'click', @hideActions

</script>
