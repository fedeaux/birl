<template lang="pug">
.executor-display
  template(v-if='custom_text')
    slot(v-if='custom_text || default_text')
    | {{ custom_text }}

  template(v-else-if='default_text')
    | {{ default_text }}
</template>

<script lang="coffee">
  export default
    props: ['default_text', 'entry', 'set_index', 'set_execution']

    computed:
      execution: ->
        @entry && @entry.value && @entry.value.sets && @entry.value.sets[@set_index] && @entry.value.sets[@set_index].execution

      custom_text: ->
        return null unless @execution

        if @execution.type == 'list' && typeof(@set_execution) == 'number'
          return @execution.values[@set_execution % @execution.values.length]

        null
</script>
