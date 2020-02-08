<template lang="pug">
.home.default-container.header-contents-footer
  .header-contents-footer-header
    h1 {{ time_now.format('ddd, MMM Do') }}

  .header-contents-footer-contents
    .home-block
      memes-types-morning-checkup-button

    .home-block(v-if='today_things_by_context')
      .seamless-title Progressions
      contexts-things(v-for='things in today_things_by_context' :things='things')

    .home-block(v-if='tags')
      .seamless-title Tags
      tags-tag-list.compact(:tags='tags')
</template>

<script lang="coffee">
  import Context from '../../models/context'
  import Session from '../../models/session'
  import Progression from '../../models/progression'
  import TagsManagerMixin from '../../mixins/tags/manager'
  import TagsResource from '../../resources/tags_resource'

  export default
    mixins: [TagsManagerMixin]

    data: ->
      time_now: moment()
      today_things_by_context: null
      morning_checkup_form: false

    methods:
      loadTags: ->
        @tags_resource ?= new TagsResource
        @tags_resource.leaves @tagsLoaded, @context

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

      performMorningCheckup: ->
        console.log 'oi'

    computed:
      morning_checkup_not_permormed: ->
        true

    mounted: ->
      @loadTodays()
</script>
