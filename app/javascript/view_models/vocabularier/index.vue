<template lang="pug">
.vocabularier(:class='klass')
  //- vocabularier-counter(v-if='state != "finished"'
  //-                  :sets_count='entry.value.sets.length'
  //-                  :current_set_target_executions='current_set_target_executions'
  //-                  :current_set_index='current_set_index'
  //-                  :current_set_execution='current_set_execution'
  //-                  :main_title='main_title'
  //-                  ref='counter'
  //- )

  .ui.form(v-if='state == "preparing"')
    .field
      label Count
      sui-dropdown(:options='count_as_options'
                   :selection='true'
                   placeholder='Count'
                   v-model='count')

    br
    br

    .ui.primary.fluid.icon.button(@click='start')
      | Start&nbsp;
      i.play.icon

  template(v-if='state == "playing"')
    .vocabularier-components
      vocabularier-item(:vocabulary='current_vocabulary')

    //- .vocabularier-label(:class='"vocabularier-label-"+state')
    //-   template(v-if='state == "idle"' @click='start')
    //-   template(v-else-if='state == "doit" || state == "rest" || state == "preparing"')
    //-     vocabularier-display(:entry='entry'
    //-                      :set_index='current_set_index'
    //-                      :set_execution='current_set_execution'
    //-                      :data_model='data_model'
    //-                      :class='{ "vocabularier-detail": state == "rest" || state == "preparing" }'
    //-                      :default_text='display_default_text')

    //-       template(v-if='state == "preparing"')
    //-         | First:&nbsp;

    //-       template(v-if='state == "rest"')
    //-         | Next:&nbsp;

    //-   template(v-else-if='state == "finished"')
    //-     | Boa, campeão! KKK
    //-     br
    //-     br

    //-     .ui.three.column.centered.grid
    //-       .column
    //-         .ui.white.fluid.button(@click='done')
    //-           | Próximo
    //-       .column
    //-         .ui.white.fluid.button(@click='addSet')
    //-           | Quero mais

    //- vocabularier-metronome(v-if='bpm && state == "doit"' :bpm='bpm')

  .vocabularier-actions
    template(v-if='state == "preparing"')

  .ui.two-buttons.vocabularier-dev-tools(v-if='dev_tools')
    .ui.basic.button(@click='stopTimer') Sthap
    .ui.basic.button(@click='current_time = 1') FF
    .ui.basic.button(@click='tick()') tick
</template>

<script lang="coffee">

import VocabulariesResource from '../../resources/vocabularies_resource'

export default
  data: ->
    state: 'preparing'
    count: 20
    current_vocabulary_index: 0
    dev_tools: false
    vocabularies: null

  methods:
    start: ->
      @vocabularies_resource.index @vocabulariesLoaded, @options

    vocabulariesLoaded: (response) ->
      @vocabularies = response.vocabularies
      @state = 'playing'

  computed:
    options: ->
      {
        limit: @count,
        random: true
      }

    current_vocabulary: ->
      return null unless @vocabularies
      @vocabularies[@current_vocabulary_index]

    count_as_options: ->
      { key: count, value: count, text: count+'' } for count in [10, 20, 30, 50, 75, 100, 200]

    fullscreen: ->
      @state != 'preparing'

    klass: ->
      classes = ["vocabularier-#{@state}"]
      classes.push ['vocabularier-fullscreen'] if @fullscreen
      classes.join ' '

  created: ->
    @vocabularies_resource = new VocabulariesResource

    @$nextTick =>
      @start()

</script>
