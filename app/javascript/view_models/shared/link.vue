<template lang="pug">
  .shared-link(@click='clicked')
    slot
</template>

<script lang="coffee">
  export default
    props: ['to']

    methods:
      clicked: ->
        if @mobile
          @$router.push @to
        else
          Global.events.$emit "Desktop::GoTo", { to: @to }
</script>
