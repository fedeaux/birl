<template lang="pug">
  .ui.action.input
    input(v-model='inner_value')
    .ui.icon.basic.button(@click='clear')
      i.cancel.icon
</template>

<script lang="coffee">
  export default
    props: ['value']

    data: ->
      inner_value: ''

    methods:
      clear: ->
        @inner_value = ''

    watch:
      inner_value:
        immediate: true
        handler: ->
          return if @inner_value == @value
          @$emit 'input', @inner_value

      value:
        immediate: true
        handler: ->
          @inner_value = @value

</script>
