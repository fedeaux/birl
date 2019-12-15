<template lang="pug">
.entity-edit.user-edit.default-container
  users-form(v-model='user'
             v-if='user'
             @save='saveUser()'
             @cancel='userDone()')
</template>

<script lang="coffee">

import UsersResource from '../../resources/users_resource'
import User from '../../models/user'

export default
  data: ->
    user: null

  methods:
    loadUser: ->
      @users_resource.get @user_id, @userLoaded

    userLoaded: (response) ->
      @user = response.user

    saveUser: ->
      @users_resource.save @user, @userDone

    userDone: ->
      @$router.push @user.path()

  computed:
    user_id: ->
      @$route.params.id

  mounted: ->
    @users_resource = new UsersResource
    @loadUser()
</script>
