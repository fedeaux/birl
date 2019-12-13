<template lang="pug">
  #birl-spa-container(@click='hideMenu()')
    sui-dimmer(:active='loading' inverted)
      sui-loader.massive

    #header
      i#side-menu-toggle.bars.icon(@click='showMenu($event)')

    #contents-wrapper
      .ui.vertical.large.menu#menu(v-if='show_menu')
        router-link.item(to='/') Today's Session
        router-link.item(to='/sessions') Sessions
        router-link.item(to='/challenges') Challenges
        router-link.item(to='/progressions') Progressions

      #contents
        router-view
</template>

<script lang="coffee">
export default
  data: ->
    show_menu: false

  methods:
    showMenu: (e) ->
      @show_menu = true
      e.stopPropagation() if $(e.target).is '#side-menu-toggle'

    hideMenu: ->
      @show_menu = false

</script>
