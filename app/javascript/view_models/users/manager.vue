<template lang="pug">
.entity-manager.users-manager.default-container
  .entity-manager-form(v-if='form_user')
    users-form(v-model='form_user'
               @save='saveFormUser()'
               @cancel='clearFormUser()')

  .entity-manager-list(v-else)
    .entity-manager-list-header
      #new-user-button.ui.primary.top.attached.fluid.small.icon.button(@click='newUser')
        i.plus.icon
        |  Add

    users-list(:users='users'
               :allow_actions='true'
               @edit='editUser($event)'
               @destroy='destroyUser($event)')
</template>

<script lang="coffee">
import UsersResource from '../../resources/users_resource'
import User from '../../models/user'

export default
  props:
    context:
      default: -> {}

    parent_users: null

  data: ->
    users: null
    form_user: null

  methods:
    editUser: (data) ->
      @setFormUser data.user

    destroyUser: (data) ->
      @users_resource.destroy data.user, @userRemoved

    loadUsers: ->
      @users_resource.index @usersLoaded, @context

    usersLoaded: (response) ->
      @users = response.users

    newUser: ->
      @setFormUser new User @context

    setFormUser: (@form_user) ->

    clearFormUser: ->
      @setFormUser null

    userIndex: (user_id) ->
      for index, user of @users
        return index if user.id == user_id

      -1

    saveFormUser: ->
      @users_resource.save @form_user, @userSaved

    addUser: (user) ->
      index = @userIndex user.id

      if index == -1
        @users.push user
        return

      Vue.set @users, index, user

    userSaved: (data) ->
      @addUser data.user
      @clearFormUser()

    userRemoved: (data) ->
      index = @userIndex data.user.id
      return if index == -1
      @users.splice index, 1

  mounted: ->
    @users_resource = new UsersResource

    if @parent_users
      @users = @parent_users
      return

    @loadUsers()
</script>
