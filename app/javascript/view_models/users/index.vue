<template lang="pug">
.entity-index.users-index.default-container
  users-manager(:users='users')
</template>

<script lang="coffee">
import UsersResource from '../../resources/users_resource'

export default
  data: ->
    users: null

  methods:
    loadUsers: ->
      @users_resource.index @usersLoaded

    usersLoaded: (response) ->
      @users = response.users

  mounted: ->
    @users_resource = new UsersResource
    @loadUsers()
</script>
