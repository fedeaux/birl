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
    props: ['default_text', 'entry', 'set_index', 'set_execution', 'data_model']

    computed:
      execution: ->
        @entry && @entry.value && @entry.value.sets && @entry.value.sets[@set_index] && @entry.value.sets[@set_index].execution

      custom_text: ->
        return null unless @execution

        text = null

        if @execution.type == 'list' && typeof(@set_execution) == 'number'
          text = @execution.values[(@set_execution - 1) % @execution.values.length]

          if @data_model && @data_model.label
            if _.isArray @data_model.label
              return "#{@data_model.label[@set_index].value} #{text}"
            else
              return "#{@data_model.label.value} #{text}"

        text
</script>
