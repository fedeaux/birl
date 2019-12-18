<template lang="pug">
.progress-bar-wrapper(:class='klass')
  .progress-bar(ref='progress_bar')
    | &nbsp;
</template>

<script lang="coffee">
  export default
    props: ['klass']

    methods:
      animate: (duration) ->
        $(@$refs.progress_bar).animate { width: '100%' }, duration

      clearWidth: ->
        $(@$refs.progress_bar).css { width: '' }

    watch:
      klass:
        immediate: true
        handler:  ->
          @clearWidth()

    mounted: ->
      @clearWidth()
</script>
