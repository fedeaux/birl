<template lang="pug">
#birl-spa-container(@click='hideMenu()')
  sui-dimmer(:active='global_loading' inverted)
    sui-loader.massive

  sui-sidebar#menu(animation='push' class='inverted' :visible='show_menu' direction='right')
    template(v-if='current_context')
      template(v-if='current_context.name == "Español"')
        router-link.item(to='/vocabularies') Vocabularies
        router-link.item(to='/questioner') Questioner

      template(v-else)
        router-link.item(to='/today') Today's Sessions
        router-link.item(to='/challenges') Challenges
        router-link.item(to='/exercises') Exercises
        router-link.item(to='/progressions') Progressions
        router-link.item(to='/sessions') Sessions
        router-link.item(to='/listers') Lists

      a.item(@click='updateContext(null)' v-if='current_context') Leave {{ current_context.name }}

    template(v-else)
      router-link.item(to='/contexts') Contexts
      router-link.item(to='/') Choose

    router-link.item(to='/tags') Tags

    //- a.item(@click='logoff') Logoff

  #header.context-dependent-background-color
    .header-button#back-button(@click='back()')
      i.angle.left.icon

    router-link.header-button#tools-toggle(to='tools')
      i.wrench.icon

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
