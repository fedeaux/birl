<template lang="pug">
.entity-list-item-wrapper.<%= dash_name %>-list-item-wrapper
  .entity-list-item-confirming-destroy(v-if='confirming_destroy && !showing_actions')
    .ui.four.column.grid
      .column
        .entity-list-item-confirming-destroy-message Are you sure?

      .column
        .ui.red.fluid.button(@click='$emit("destroy")') Yes

      .column
        .ui.basic.fluid.button(@click='cancelDestroy()') No

  .action-menu(v-if='!confirming_destroy && showing_actions')
    <%= link_tag %>.action-menu-item(:to='<%= underscore_name %>.path()')
       i.eye.green.icon

    .action-menu-item(@click='$emit("edit")')
       i.edit.blue.icon

    .action-menu-item(@click='confirmDestroy')
       i.trash.red.icon

    .action-menu-item(@click='hideActions()')
       i.cancel.icon

  <%= link_tag %>.entity-list-item.<%= dash_name %>-list-item(v-if='!confirming_destroy && !showing_actions'
                    <%= link_tag_as_spaces %><%= dash_name_as_spaces %><%= spaces(11) %>:to='<%= underscore_name %>.path()')
    <%= plural_dash_name %>-display(:<%= underscore_name %>='<%= underscore_name %>'
    <%= plural_dash_name_as_spaces %><%= spaces(9) %>:allow_actions='allow_actions'
    <%= plural_dash_name_as_spaces %><%= spaces(9) %>@action='showActions')
      i.ellipsis.vertical.icon
</template>

<script lang="coffee">

export default
  props:
    <%= underscore_name %>:
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
