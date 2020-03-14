<template lang="pug">
.memes-stream-list-item-wrapper(:class='klass')
  .entity-list-item-confirming-destroy(v-if='confirming_destroy && !showing_actions')
    .ui.four.column.grid
      .column
        .entity-list-item-confirming-destroy-message Are you sure?

      .column
        .ui.red.fluid.button(@click='$emit("destroy")') Yes

      .column
        .ui.basic.fluid.button(@click='cancelDestroy()') No

  .action-menu(v-if='!confirming_destroy && showing_actions')
    .action-menu-item(@click='copyToClipboard')
       i.copy.olive.icon

    shared-link.action-menu-item(:to='meme.path()')
       i.eye.green.icon

    .action-menu-item(@click='$emit("edit")')
       i.edit.blue.icon

    .action-menu-item(@click='confirmDestroy')
       i.trash.red.icon

    .action-menu-item(@click='hideActions()')
       i.cancel.icon

  .entity-list-item.meme-list-item(v-if='!confirming_destroy && !showing_actions')
    memes-display(:meme='meme'
                  :context='context'
                  :allow_actions='allow_actions'
                  @action='showActions')
      i.ellipsis.vertical.icon(v-if='!selected')
</template>

<script lang="coffee">

export default
  props:
    context:
      default: {}

    meme:
      required: true

    allow_actions:
      default: false

    selected:
      default: false

    previous_selected:
      default: false

    next_selected:
      default: false

  computed:
    klass: ->
      return '' unless @selected

      classes = ['selected']
      classes.push 'with-previous-selected' if @previous_selected
      classes.push 'with-next-selected' if @next_selected
      classes.join(' ')

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

    copyToClipboard: ->
      navigator.clipboard.writeText @meme.contents.title

</script>
