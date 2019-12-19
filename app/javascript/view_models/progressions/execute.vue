<template lang="pug">
.entity-show-wrapper.progressions-show-wrapper.default-container(v-if='progression')
  .entity-show.progressions-show
    progressions-display(:progression='progression')
      router-link.entity-show-header-actions(:to='progression.path()')
        i.eye.icon

  entries-manager(:context='{ progression_id: progression_id }'
                  :data_model='progression.entry_data_model'
                  :actions='{ add: false, form: { actions: false } }'
                  ref='entries_manager')

  executor-index(v-if='executable_entry'
                 :data_model='progression.entry_data_model'
                 :entry='executable_entry'
                 :main_title='progression.name'
                 @entrySetUpdated='entrySetUpdated'
                 @done='done'
                 ref='executor')

  shared-footer
    .ui.primary.fluid.button(@click='prepare' v-if='state == "idle"')
      | Prepare&nbsp;&nbsp;

    .ui.primary.fluid.button(@click='execute' v-if='state == "preparing"')
      | Execute&nbsp;&nbsp;
      i.play.icon

    template(v-if='show_in_session')
      hr
      progressions-in-session(:current_progression_id='progression_id'
                              ref='in_session')
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'

export default
  props:
    parent_progression: null

  data: ->
    progression: null
    progression_id: null
    executable_entry: null
    state: 'idle'

  methods:
    reset: ->
      @state = 'idle'
      @progression = null

      @$nextTick =>
        @progressions_resource ?= new ProgressionsResource
        @progression_id = parseInt @$route.params.id
        @loadProgression()

    done: ->
      @$refs.entries_manager.saveFormEntry @entrySaved

    entrySetUpdated: (data) ->
      @$refs.entries_manager.entrySetUpdated data

    entrySaved: ->
      unless @$refs.in_session && @$refs.in_session.navigateToNext()
        @$refs.executor.reset()

    prepare: ->
      return unless @$refs.entries_manager
      @state = 'preparing'
      @$refs.entries_manager.newEntry()

    execute: ->
      @setExecutableEntry @$refs.entries_manager.populateFormEntry()

      @$nextTick =>
        @$refs.executor.start()

    loadProgression: ->
      @progressions_resource.get @progression_id, @progressionLoaded

    progressionLoaded: (response) ->
      @progression = response.progression

    setExecutableEntry: (@executable_entry) ->

  computed:
    show_in_session: ->
      @current_session && @current_session.progressions &&
        @progression_id in (p.id for p in @current_session.progressions)

  mounted: ->
    if @parent_progression
      @progression = @parent_progression

  watch:
    '$route.params.id':
      immediate: true
      handler: ->
        @reset()
</script>
