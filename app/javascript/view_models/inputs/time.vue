<template lang="pug">
  .ui.input
    input.time(v-model='display_value')
</template>

<script lang="coffee">
  export default
    props: ['value']

    data: ->
      inner_value: moment()
      display_value: ''

    watch:
      display_value:
        immediate: true
        handler: ->
          parts = @display_value.split ':'
          return unless parts.length == 2 and parts[1].length == 2

          new_inner_value = @inner_value.clone().set(hour: parseInt(parts[0]), minute: parseInt(parts[1]))
          return if @inner_value.isSame new_inner_value

          @$emit 'input', new_inner_value

      inner_value:
        immediate: true
        handler: ->
          @display_value = @inner_value.format('HH:mm')

      value:
        immediate: true
        handler: ->
          return if @inner_value and @value and @inner_value.isSame @value
          return @inner_value = moment() unless @value

          @inner_value = @value
</script>
