<template lang="pug">
#birl-spa-container(@click='hideMenu()')
  sui-dimmer(:active='global_loading' inverted)
    sui-loader.massive

  sui-sidebar#menu(animation='push' class='inverted' :visible='show_menu' direction='right')
    router-link.item(to='/today') Today's Sessions
    router-link.item(to='/challenges') Challenges
    router-link.item(to='/exercises') Exercises
    router-link.item(to='/progressions') Progressions
    router-link.item(to='/sessions') Sessions
    router-link.item(to='/listers') Lists
    a.item(@click='logoff') Logoff

    a.item(@click='updateContext(null)' v-if='current_context') Leave {{ current_context.name }}

  #header.context-dependent-background-color
    .header-button#back-button(@click='back()')
      i.angle.left.icon

    .header-button#side-menu-toggle(@click='toggleMenu($event)')
      i.bars.icon

  #contents-wrapper
    #contents
     router-view
</template>

<script lang="coffee">

export default
  data: ->
    show_menu: false

  methods:
    logoff: ->
      $.ajax
        method: 'delete'
        url: Global.server.links.logoff
        complete: (a, b, c) ->
          console.log a, b, c

    toggleMenu: (e) ->
      @show_menu = !@show_menu
      e.stopPropagation() if $(e.target).is 'i.bars.icon, #side-menu-toggle'

    hideMenu: ->
      @show_menu = false

    back: ->
      @$router.go -1

  created: ->
    @setInitialUser()

</script>
