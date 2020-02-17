<template lang="pug">
.entry-value-display(v-if="value")
  .entry-value-display-element(v-for='element in elements' :class='element.class')
    | {{ element.text }}
</template>

<script lang="coffee">
  export default
    props:
      value:
        required: true

    computed:
      elements: ->
        els = []

        for formatted_set in @value.formattedSets()
          els.push formatted_set
          els.push { text: ' / ', class: 'rest' }

        els[0..-2]
</script>
