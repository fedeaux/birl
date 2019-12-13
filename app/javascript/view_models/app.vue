<template lang="pug">
#birl-spa-container(@click='hideMenu()')
  sui-dimmer(:active='global_loading' inverted)
    sui-loader.massive

  sui-sidebar#menu(animation='push' class='inverted' :visible='show_menu' direction='right')
    router-link.item(to='/') Today's Session
    router-link.item(to='/sessions') Sessions
    router-link.item(to='/challenges') Challenges
    router-link.item(to='/progressions') Progressions

  #header
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
    toggleMenu: (e) ->
      @show_menu = !@show_menu
      e.stopPropagation() if $(e.target).is 'i.bars.icon, #side-menu-toggle'

    hideMenu: ->
      @show_menu = false

    back: ->
      @$router.go -1

</script>
