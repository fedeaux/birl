<template lang="pug">
.entity-display(v-if="<%= underscore_name %>")
  .entity-display-main
    | {{ <%= underscore_name %>.name }}

    .entity-display-detail
<%= sub_template('Details', '//-', 6) %>

  .top-right-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      <%= underscore_name %>:
        required: true

      allow_actions:
        default: true

    methods:
      action: (event) ->
        event.preventDefault()
        event.stopPropagation()
        @$emit 'action', event

<%= sub_template('Other', '#', 4) %>
</script>
