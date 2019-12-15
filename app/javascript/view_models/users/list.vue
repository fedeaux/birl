<template lang="pug">
.entity-list.user-list.default-container
  users-list-item(v-for='user in users'
                  v-if='users'
                  :user='user'
                  :allow_actions='allow_actions'
                  :key='user.id'
                  @edit='$emit("edit", { user: user })'
                  @destroy='$emit("destroy", { user: user })')

  entity-list-empty(v-if='!users || users.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    users:
      default: null
</script>
