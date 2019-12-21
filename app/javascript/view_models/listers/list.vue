<template lang="pug">
.entity-list.lister-list.default-container
  listers-list-item(v-for='lister in listers'
                    v-if='listers'
                    :lister='lister'
                    :allow_actions='allow_actions'
                    :key='lister.id'
                    @edit='$emit("edit", { lister: lister })'
                    @destroy='$emit("destroy", { lister: lister })')

  entity-list-empty(v-if='!listers || listers.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    listers:
      default: null
</script>
