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
        last_set = null

        for set in @value.sets
          if last_set
            els.push { class: 'rest', text: ' / ' }

          els.push { class: 'set', text: set.human() }
          last_set = set

        els

</script>
