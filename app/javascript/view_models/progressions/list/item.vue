<template lang="pug">
.entity-list-item-wrapper.progression-list-item-wrapper
  .entity-list-item-confirming-destroy(v-if='confirming_destroy')
    .ui.red.message
      .centered Confirm destroy?

    .ui.small.fluid.buttons
      .ui.red.button(@click='$emit("destroy")') Destroy
      .ui.basic.button(@click='cancelDestroy()') Cancel

  .entity-list-item.progression-list-item(v-else)
    router-link(:to='progression.path()')
      | {{ progression.name }}

    router-link.entity-list-item-detail(:to='progression.path()')
      template(v-if='progression.entries_count')
        | {{ progression.entries_count }}
        |  entries
      template(v-else)
        |  never trained

    .entity-list-item-actions-wrapper(v-if='allow_actions')
      i.ellipsis.vertical.icon(@click.stop='showActions($event)' v-if='!show_actions')

      .ui.vertical.text.menu.entity-list-item-actions(v-if='show_actions')
        router-link.item(:to='progression.path()')
          | View
          i.eye.icon

        .item(@click.stop='edit($event)')
          | Edit
          i.edit.icon

        .item(@click.stop='confirmDestroy($event)')
          | Destroy
          i.trash.icon

  entity-list-item-divider
</template>

<script lang="coffee">

export default
  data: ->
    confirming_destroy: false
    show_actions: false

  props:
    progression:
      required: true

    allow_actions:
      default: false

  methods:
    confirmDestroy: ($event) ->
      @confirming_destroy = true
      $event.stopPropagation()

    cancelDestroy: ->
      @confirming_destroy = false

    edit: ($event) ->
      @$emit 'edit'
      $event.stopPropagation()

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
