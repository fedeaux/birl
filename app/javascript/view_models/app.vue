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
    i#side-menu-toggle.bars.icon(@click='toggleMenu($event)')

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
      e.stopPropagation() if $(e.target).is '#side-menu-toggle'

    hideMenu: ->
      @show_menu = false

</script>
