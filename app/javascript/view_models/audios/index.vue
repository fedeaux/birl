<template lang="pug">
  .audios.default-container
    template(v-for='schema in schemas')
      h1 {{ schema }}

      h2 Events
      template(v-for='event in events(schema)')
        br
        .ui.primary.fluid.icon.button(@click='playEvent(event, schema)')
           | {{ event }}
           | &nbsp;
           i.play.icon

      h2 All
      template(v-for='audio in audios(schema)')
        br
        .ui.primary.fluid.icon.button(@click='play(audio, schema)')
           | {{ audio }}
           | &nbsp;
           i.play.icon

</template>

<script lang="coffee">
  export default
    methods:
      playEvent: (event, schema) ->
        Global.player.event event, schema

      play: (audio, schema) ->
        Global.player.play audio, schema

      events: (schema) ->
        Global.player.availableEvents schema

      audios: (schema) ->
        Global.player.availableAudios schema

    computed:
      schemas: ->
        Global.player.schemas()
</script>
