<template lang="pug">
  .context-things(:style='things_style')
    //- .context-things-context-name(:style='context_name_style') {{ context.name }}

    .context-things-thing(v-for='session in things.sessions'
                          @click='goToSession(session)'
                          :style='thing_style')
      | {{ session.name }}

    .context-things-thing(v-for='progression in things.progressions'
                          @click='goToProgression(progression)'
                          :style='thing_style')
      | {{ progression.name }}

    .context-things-thing(v-for='raw_link in things.raw_links'
                          @click='goToRawLink(raw_link)'
                          :style='thing_style')
      | {{ raw_link.name }}

</template>

<script lang="coffee">
  export default
    props: ['things']

    methods:
      goToSession: (session) ->
        @updateContext @context, =>
          @$router.push session.path()

      goToProgression: (progression) ->
        @updateContext @context, =>
          @$router.push progression.executePath()

      goToRawLink: (raw_link) ->
        @updateContext @context, =>
          @$router.push raw_link.path

    computed:
      context: ->
        @things.context

      things_style: ->
        { "border-color": @context.color }

      context_name_style: ->
        @context.backgroundColor()

      thing_style: ->
        { "border-color": @context.color, color: @context.color }

</script>
