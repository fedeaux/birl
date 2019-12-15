<template lang="pug">
  sui-dropdown(:options='users_as_options'
               :loading='loading'
               :search='true'
               :selection='true'
               placeholder='User'
               v-model='selected_user_id')
</template>

<script lang="coffee">
import UsersResource from '../../resources/users_resource'

export default
  model:
    prop: 'user_id'

  props:
    user_id: null

  data: ->
    users: null
    selected_user_id: null

  methods:
    loadUsers: ->
      @users_resource.index @usersLoaded

    usersLoaded: (response) ->
      @users = response.users

    userIndex: (user_id) ->
      for index, user of @users
        return index if user.id == user_id

      -1

    getUser: (user_id) ->
      index = @userIndex user_id
      return null if index == -1
      @users[index]

  computed:
    loading: ->
      !@users

    users_as_options: ->
      return [] unless @users
      { key: user.id, value: user.id, text: user.name } for user in @users

  watch:
    selected_user_id: ->
      @$emit 'input', @selected_user_id

    user_id:
      immediate: true
      handler: ->
        return unless @user_id
        @selected_user_id = parseInt @user_id

  mounted: ->
    @users_resource = new UsersResource
    @loadUsers()

</script>
