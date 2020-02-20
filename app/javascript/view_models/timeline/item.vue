<template lang="pug">
.timeline-item-wrapper(:style='style')
  .entity-timeline-item-confirming-destroy(v-if='confirming_destroy && !showing_actions')
    .ui.four.column.grid
      .column
        .entity-timeline-item-confirming-destroy-message Are you sure?

      .column
        .ui.red.fluid.button(@click='$emit("destroy")') Yes

      .column
        .ui.basic.fluid.button(@click='cancelDestroy()') No

  .action-menu(v-if='!confirming_destroy && showing_actions')
    .action-menu-item(@click='$emit("edit")')
       i.edit.blue.icon

    .action-menu-item(@click='confirmDestroy')
       i.trash.red.icon

    .action-menu-item(@click='hideActions()')
       i.cancel.icon

  .timeline-item(v-if='!confirming_destroy && !showing_actions')
    .timeline-item-header
      .timeline-item-header-actions
        i.ellipsis.vertical.icon(@click='showActions')

      .timeline-item-header-tag
        | {{ timelineable.main_tag.fullname }}

    .timeline-item-body
      | {{ timelineable.description }}

    .timeline-item-footer
      .timeline-item-footer-range
        | {{ timelineable.start && timelineable.start.format('hh:mm') }}
        | &rarr;
        | {{ timelineable.finish && timelineable.finish.format('hh:mm') }}
      .timeline-item-footer-duration
        | ({{ timelineable.formattedDuration()}})

</template>

<script lang="coffee">
  export default
    props:
      timelineable:
        required: true

    data: ->
      showing_actions: false
      confirming_destroy: false

    computed:
      style: ->
        return { display: "none" } unless @timelineable.start && @timelineable.finish

        start_of_day = @timelineable.start.clone().startOf 'day'
        end_of_day = @timelineable.start.clone().endOf 'day'

        top = @snapToGrid(@timelineable.start.diff start_of_day, 'minutes') + 1
        height = @snapToGrid(@timelineable.finish.diff @timelineable.start, 'minutes') - 3
        height = Math.max height, 10

        {
          top: "#{top}px"
          height: "#{height}px"
          color: @timelineable.color()
          'background-color': @timelineable.background_color()
        }

    methods:
      snapToGrid: (position) ->
        parseInt(position / 10) * 10

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
