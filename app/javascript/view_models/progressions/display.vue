<template lang="pug">
.entity-display(v-if="progression")
  .entity-display-main(:class='klass')
    | {{ progression.exercise_name }}

    template(v-if='progression.done_today')
      | &nbsp;
      i.checkmark.small.icon

    .entity-display-detail(v-html='details')
      //- BrainDamage: Details Start
      //- BrainDamage: Details End

  .top-right-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      progression:
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
        return 'text-green' if @progression.done_today

      details: ->
        els = []

        if @progression.challenge_name != @progression.name
          els.push @progression.challenge_name

        if @progression.details
          els.push @progression.details

        if @progression.entries_count > 0
          els.push @progression.entries_count
        else
          els.push 'Never trained'

        if @progression.last_entry_at
          els.push @progression.last_entry_at.fromNow()

        els.join ' &middot; '
</script>
