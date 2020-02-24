<template lang="pug">
.executor-display
  template(v-if='custom_value')
    slot(v-if='custom_value || default_text')
    executor-display-value(:value='custom_value')

  template(v-else-if='default_text')
    | {{ default_text }}
</template>

<script lang="coffee">
  export default
    props: ['default_text', 'entry', 'set_index', 'set_execution', 'data_model']

    computed:
      execution: ->
        @entry && @entry.value && @entry.value.sets && @entry.value.sets[@set_index] && @entry.value.sets[@set_index].execution

      custom_value: ->
        return null unless @execution and typeof(@set_execution) == 'number'

        @execution.getValue @set_execution

      custom_text: ->
        return unless @custom_value and @custom_value.text
        text = @custom_value.text

        if @data_model && @data_model.label
          if _.isArray @data_model.label
            return "#{@data_model.label[@set_index].value} #{text}"
          else
            return "#{@data_model.label.value} #{text}"

        text

      # details: ->
      #   return false unless @execution and
      #                  @execution.variations and
      #                  @execution.type == 'list' and
      #                  typeof(@set_execution) == 'number'

      #   @execution.variations[(@set_execution - 1) % @execution.variations.length]

</script>
