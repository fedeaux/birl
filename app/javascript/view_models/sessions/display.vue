<template lang="pug">
.entity-display(v-if="session")
  .entity-display-main(:class='klass')
    | {{ session.name }}

    template(v-if='session.done_today')
      | &nbsp;
      i.checkmark.small.icon

  .entity-display-detail
    | {{ session.human_weekday }}

  .entity-display-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      session:
        required: true

      allow_actions:
        default: true

    methods:
      action: (event) ->
        event.preventDefault()
        event.stopPropagation()
        @$emit 'action', event

   computed:
     klass: ->
       return 'text-green' if @session.done_today
</script>
