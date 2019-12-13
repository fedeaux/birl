<template lang="pug">
router-link.<%= underscore_name %>-list-item-contents(:to='<%= underscore_name %>.path()')
  | {{ <%= underscore_name %>.name }}
</template>

<script lang="coffee">
  export default
    props:
      <%= underscore_name %>:
        required: true
</script>
