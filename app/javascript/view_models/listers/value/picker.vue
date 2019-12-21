<template lang="pug">
.listers-value-picker
  .ui.action.input.listers-value-picker-item(v-for='(item, index) in inner_value.items')
    input(v-model='inner_value.items[index]'
          @input='changed')

    .ui.icon.red.button.items-remover(@click='removeItem(index)')
      i.minus.icon

  .listers-value-picker-actions
    .ui.icon.primary.small.circular.button(@click='addItem')
      i.plus.icon

    .ui.icon.primary.small.circular.button(@click='sortItems')
      i.sort.alphabet.down.icon

</template>

<script lang="coffee">
  export default
    props:
      data_model: {}
      value: {}

    data: ->
      inner_value: null

    methods:
      changed: ->
        @$emit 'input', @inner_value

      addItem: ->
        @inner_value.items.push ''
        @changed()

      removeItem: (index) ->
        @inner_value.items.splice index, 1
        @changed()

      sortItems: ->
        @inner_value.items = (item for item in @inner_value.items.sort() when item.length > 0)
        @changed()

    watch:
      value:
        immediate: true
        handler: ->
          if @value and @value.items
            @inner_value = JSON.parse JSON.stringify @value
          else
            @inner_value = { items: [] }
</script>
