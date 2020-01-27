<template lang="pug">
  .home.default-container
    h1 {{ time_now.format('ddd, MMM Do') }}

    div(v-if='today_things_by_context')
      contexts-things(v-for='things in today_things_by_context' :things='things')

    h2 Favorite Tags

</template>

<script lang="coffee">
  import Context from '../../models/context'
  import Session from '../../models/session'
  import Progression from '../../models/progression'

  export default
    data: ->
      time_now: moment()
      today_things_by_context: null

    methods:
      todaysLoaded: (data) ->
        @today_things_by_context = []

        for things in data.things_by_context
          context = new Context things.context
          sessions = ((new Session session) for session in (things.sessions || []))
          progressions = ((new Progression progression) for progression in (things.progressions || []))

          @today_things_by_context.push
            context: context
            sessions: sessions
            progressions: progressions
            raw_links: things.raw_links

      loadTodays: ->
        $.ajax
          url: "#{Global.server.base_url}/api/v1/sessions/todays"
          method: 'get'
          success: @todaysLoaded

    mounted: ->
      @loadTodays()
</script>
