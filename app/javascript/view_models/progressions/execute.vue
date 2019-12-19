<template lang="pug">
.entity-show-wrapper.progressions-show-wrapper.default-container(v-if='progression')
  .entity-show.progressions-show
    progressions-display(:progression='progression')
      router-link.entity-show-header-actions(:to='progression.path()')
        i.eye.icon

  template(v-if='!editing_entry')
    template(v-if='todays_entry')
      .ui.green.message Done!

      entries-list-item(:entry='todays_entry')
      .ui.fluid.buttons
        .ui.primary.button(@click='doAnother()' v-if='new_entry && !new_entry.id')
          | Do another
        .ui.basic.button(@click='editTodaysEntry()')
          | Edit

      executor-index(:entry='executable_entry')

    .centered(v-else @click='doIt')
      .ui.primary.large.button
        | Do

  entries-form(v-model='new_entry'
               v-if='editing_entry'
               :data_model='progression.entry_data_model'
               @save='saveFormEntry()'
               @cancel='clearFormEntry()')

  template(v-if='progression.entries.length > 0')
    h3 Older Entries
    entries-list(:entries='progression.entries')

  shared-footer(v-if='show_shared_footer')
    progressions-in-session(:current_progression_id='progression_id')
</template>

<script lang="coffee">
import ProgressionsResource from '../../resources/progressions_resource'
import EntriesResource from '../../resources/entries_resource'
import Entry from '../../models/entry'

export default
  props:
    parent_progression: null

  data: ->
    progression: null
    progression_id: null
    new_entry: null
    todays_entry: null
    editing_entry: true

  methods:
    editTodaysEntry: ->
      @new_entry = @todays_entry
      @todays_entry = null
      @editing_entry = true

    doAnother: ->
      @editing_entry = true

    loadProgression: ->
      @progressions_resource.execute @progression_id, @progressionLoaded

    progressionLoaded: (response) ->
      @progression = response.progression
      @new_entry = @progression.new_entry
      @todays_entry = @progression.todays_entry
      @editing_entry = !@todays_entry

    saveFormEntry: ->
      @entries_resource.save @new_entry, @entrySaved

    entrySaved: (data) ->
      @new_entry = data.entry
      @editing_entry = false
      @todays_entry = @new_entry unless @todays_entry

    clearFormEntry: ->
      @editing_entry = false

      if @new_entry.isPersisted()
        @today_entry = @new_entry

    doIt: ->
      @editing_entry = true

  computed:
    show_shared_footer: ->
      @current_session && @current_session.progressions &&
        @progression_id in (p.id for p in @current_session.progressions)

    executable_entry: ->
      return @todays_entry if @todays_entry
      @new_entry

  mounted: ->
    @entries_resource = new EntriesResource

    if @parent_progression
      @progression = @parent_progression
      return

  watch:
    '$route.params.id':
      immediate: true
      handler: ->
        @progressions_resource ?= new ProgressionsResource
        @progression_id = parseInt @$route.params.id
        @loadProgression()
</script>
