<template lang="pug">
.questioner-item-wrapper.default-container(v-if='vocabulary')
  .entity-list-item-confirming-destroy(v-if='confirming_destroy')
    .ui.four.column.grid
      .column
        .entity-list-item-confirming-destroy-message Are you sure?

      .column
        .ui.red.fluid.button(@click='$emit("destroy")') Yes

      .column
        .ui.basic.fluid.button(@click='cancelDestroy()') No

  template(v-else)
    .questioner-item
      .questioner-item-label
       | {{ vocabulary.kind }}
       | &nbsp;&middot;&nbsp;
       | {{ vocabulary.id }}

      .questioner-item-display
        .questioner-item-display-label
          .question
            | {{ displays[0].label }}
          .answer
            | {{ displays[1].label }}

        .questioner-item-display-text
          .question
            | {{ displays[0].text }}
          .answer
            template(v-if='show_answer')
              | {{ displays[1].text }}
            template(v-else)
              | ?

    .questioner-item-actions
      template(v-if='show_answer')
        .right-wrong-buttons
          .ui.two.large.buttons
            .ui.fluid.red.icon.button(@click='$emit("wrong")')
              i.cancel.icon

            .ui.fluid.green.icon.button(@click='$emit("right")')
              i.checkmark.icon

        .edit-delete-buttons
          .ui.three.small.buttons
            .ui.basic.fluid.blue.icon.button(@click='$emit("edit")')
              i.edit.icon

            .ui.basic.fluid.red.icon.button(@click='confirmDestroy')
              i.trash.icon

            .ui.basic.fluid.green.icon.button(@click='doubleCheck')
              i.question.circle.outline.icon

      template(v-else)
        .right-wrong-buttons
          .ui.primary.fluid.large.icon.button(@click='$emit("showAnswer")')
            | Show&nbsp;
            i.eye.icon
        .edit-delete-buttons
          .ui.basic.fluid.icon.button(@click='$emit("back")')
            i.arrow.alternate.circle.left.outline.icon
            | &nbsp;
            | Back
</template>

<script lang="coffee">
export default
  props:
    vocabulary: null
    direction: true
    show_answer: false

  data: ->
    confirming_destroy: false

  methods:
    confirmDestroy: ->
      @confirming_destroy = true
      @showing_actions = false

    cancelDestroy: ->
      @confirming_destroy = false

    doubleCheck: ->
      query = "#{@vocabulary.pt_br} em espanhol".replace ' ', '+'
      window.open "https://www.google.com/search?q=#{query}"

  computed:
    displays: ->
      if @direction == "es => pt_br"
        return [{ label: 'es', text: @vocabulary.es }, { label: 'pt', text: @vocabulary.pt_br }]

      [{ label: 'pt', text: @vocabulary.pt_br }, { label: 'es', text: @vocabulary.es }]

  watch:
    vocabulary:
      deep: true
      handler: ->
        @confirming_destroy = false

</script>
