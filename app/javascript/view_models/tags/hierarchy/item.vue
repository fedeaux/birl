<template lang="pug">
.entity-hierarchy-item-wrapper.tags-hierarchy-item-wrapper(v-if='tag')
  .entity-list-item-confirming-destroy(v-if='confirming_destroy && !showing_actions')
    .ui.four.column.grid
      .column
        .entity-list-item-confirming-destroy-message Are you sure?

      .column
        .ui.red.fluid.button(@click='destroy') Yes

      .column
        .ui.basic.fluid.button(@click='cancelDestroy()') No

  .entity-list-item-actions(v-if='!confirming_destroy && showing_actions')
    .ui.four.column.grid
      .column
        .ui.basic.fluid.green.icon.button(@click='newChild')
          i.add.icon

      .column(@click='edit')
        .ui.basic.fluid.blue.icon.button
          i.edit.icon

      .column(@click='confirmDestroy')
        .ui.basic.fluid.red.icon.button
          i.trash.icon

      .column(@click='hideActions()')
        .ui.basic.fluid.icon.button
          i.cancel.icon

  .tags-hierarchy-item
    tags-display(v-if='!confirming_destroy && !showing_actions' :tag='tag' :state='state' @toogleState='toogleState' @action='showActions')
      i.ellipsis.vertical.icon

    tags-hierarchy(v-if='state == "open" && tag.children.length > 0'
                   :parent_tags='tag.children'
                   :depth='depth + 1')
</template>

<script lang="coffee">
export default
  props:
    tag:
      default: null

    depth:
      default: 0

  data: ->
    state: null
    showing_actions: false
    confirming_destroy: false

  methods:
    toogleState: ->
      return @state = null unless @has_children
      @state = @state == 'open' and 'closed' or 'open'

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

    edit: ->
      Global.events.$emit 'Tags::Hierarchy::Edit', tag: @tag

    destroy: ->
      Global.events.$emit 'Tags::Hierarchy::Destroy', tag: @tag

    newChild: ->
      attributes = { parent_id: @tag.id, color: @tag.color, background_color: @tag.background_color }
      Global.events.$emit 'Tags::Hierarchy::New', tag_attributes: attributes

  computed:
    has_children: ->
      @tag && @tag.children && @tag.children.length > 0

    # klass: ->
    #   return 'showing-actions' if @showing_actions

  mounted: ->
    return @state = null unless @has_children
    @state = @depth < 2 and 'open' or 'closed'

</script>
