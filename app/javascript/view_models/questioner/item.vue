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
      .ui.two.small.basic.buttons.questioner-item-prioritizer
        .ui.red.button(v-if='vocabulary.priority != 2' @click='$emit("updatePriority", { priority: 2 })') high
        .ui.orange.button(v-if='vocabulary.priority != 1' @click='$emit("updatePriority", { priority: 1 })') medium
        .ui.green.button(v-if='vocabulary.priority != 0' @click='$emit("updatePriority", { priority: 0 })') low

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

        .questioner-item-display-doublecheck
          .question
            i.question.circle.outline.icon(@click='doubleCheckQuestion')
          .answer
            i.question.circle.outline.icon(@click='doubleCheckAnswer')

    .questioner-item-actions
      template(v-if='show_answer')
        .right-wrong-buttons
          .ui.two.large.buttons
            .ui.fluid.red.icon.button(@click='$emit("wrong")')
              i.cancel.icon

            .ui.fluid.green.icon.button(@click='$emit("right")')
              i.checkmark.icon

        .edit-delete-buttons
          .ui.two.small.buttons
            .ui.basic.fluid.blue.icon.button(@click='$emit("edit")')
              i.edit.icon

            .ui.basic.fluid.red.icon.button(@click='confirmDestroy')
              i.trash.icon

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

    openGoogleTranslateUrl: (from, to, text) ->
      text = text.split('/')[0]
      window.open "https://translate.google.com/#view=home&op=translate&sl=#{from}&tl=#{to}&text=#{text}"

    doubleCheckQuestion: ->
      if @direction == 'es => pt_br'
        @openGoogleTranslateUrl 'es', 'pt', @vocabulary.es
      else
        @openGoogleTranslateUrl 'pt', 'es', @vocabulary.pt_br

    doubleCheckAnswer: ->
      if @direction == 'es => pt_br'
        @openGoogleTranslateUrl 'pt', 'es', @vocabulary.pt_br
      else
        @openGoogleTranslateUrl 'es', 'pt', @vocabulary.es

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
