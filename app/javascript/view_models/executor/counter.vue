<template lang="pug">
.executor-counter
  .executor-counter-main-title(v-if='main_title') {{ main_title }}

  .executor-counter-sets(v-if='sets_count > 1')
    .executor-counter-sets-set(v-for='index in counterSetsFillerBefore()' :key='index')
    .executor-counter-sets-set(v-for='index in sets_count' :class='counterSetClass(index - 1)')
      i.checkmark.icon
      span {{ index }}
      i.clock.icon
    .executor-counter-sets-set(v-for='index in counterSetsFillerAfter()')

  .executor-counter-executions(v-if='current_set_target_executions > 1')
    executor-progress-bar.executor-counter-executions-execution(v-for='index in current_set_target_executions' :klass='counterExecutionClass(index)' :ref='"progress_bar_"+index' :key='current_set_index+"-"+index')

</template>

<script lang="coffee">
export default
  props: ['sets_count', 'current_set_target_executions', 'current_set_index', 'current_set_execution', 'main_title']

  methods:
    counterSetsFillerBefore: ->
      @sets_count - @current_set_index - 1

    counterSetsFillerAfter: ->
      @current_set_index

    counterSetClass: (index) ->
      return 'current' if index == @current_set_index
      return 'done' if index < @current_set_index
      'pending'

    counterExecutionClass: (index) ->
      return 'current' if index == @current_set_execution
      return 'done' if index < @current_set_execution
      'pending'

    animate: (duration) ->
      return unless @$refs["progress_bar_#{@current_set_execution}"]
      @$refs["progress_bar_#{@current_set_execution}"][0].animate duration

    reset: ->
      for progress_bar in @$refs
        continue unless progress_bar
        p.reset() for p in progress_bar when p.reset
</script>
