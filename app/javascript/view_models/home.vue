<template lang="pug">
  component(:is='device_home')
</template>

<script lang="coffee">
export default
  data: ->
    force: null

  computed:
    device_home: ->
      @device.homeComponentName()
</script>
