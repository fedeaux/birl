<template lang="pug">
.entity-display(v-if="meme")
  .entity-display-main
    .memes-display-todo-checkbox-wrapper(v-if='meme.type == "Todo"' v-model='done')
      sui-checkbox
    | {{ text }}

    //- BrainDamage: Details Start
    tags-tags(:tags='meme.tags' :hide='context.tag_id')
    //- BrainDamage: Details End

  .top-right-actions(v-if='allow_actions' @click='action($event)')
    slot
</template>

<script lang="coffee">
  export default
    props:
      meme:
        required: true

      allow_actions:
        default: true

      context:
        default: {}

    data: ->
      done: !!@meme.done_at

    computed:
      text: ->
        return "Meme ##{@meme.id}" unless @meme.contents and @meme.contents.title
        @meme.contents.title

    methods:
      action: (event) ->
        event.preventDefault()
        event.stopPropagation()
        @$emit 'action', event

      update: (attributes) ->
        @$emit 'update', attributes

    watch:
      done: ->
        if @done
          @$emit 'update', { done_at: moment() }
          return

        @$emit 'update', { done_at: null }

    # BrainDamage: Other Start
    # BrainDamage: Other End
</script>
