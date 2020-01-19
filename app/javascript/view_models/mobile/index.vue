<template lang="pug">
#birl-spa-container(@click='hideMenu()' :class='klass')
  #fullscreen(v-if='show_memes || choose_context')
    i.cancel.icon#fullscreen-close(@click='show_memes = false; choose_context = false')
    memes-index(v-if='show_memes')

    template(v-if='choose_context')
      br
      br
      contexts-choose

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
      router-link.item(to='/contexts/choose') Choose

    router-link.item(to='/tags') Tags
    router-link.item(to='/') Memes

    //- a.item(@click='logoff') Logoff

  #header.context-dependent-background-color
    .header-button#back-button(@click='back()')
      i.angle.left.icon

    //- .header-button#contexts-toggle(@click='choose_context = !choose_context')
    //-   i.bars.icon

    .header-button#home-link(@click='goHome')
      i.home.icon

    .header-button#memes-toggle(@click='show_memes = !show_memes')
      i.sticky.note.outline.icon

    .header-button#side-menu-toggle(@click='toggleMenu($event)')
      i.ellipsis.vertical.icon

  #contents-wrapper
    #contents
      router-view
</template>

<script lang="coffee">
  export default
    data: ->
      show_menu: false
      show_memes: true
      choose_context: false

    methods:
      goHome: ->
        @updateContext null, =>
          @$router.push '/'

      toggleMenu: (e) ->
        @show_menu = !@show_menu
        e.stopPropagation() if $(e.target).is 'i.ellipsis.vertical.icon, #side-menu-toggle'

      hideMenu: ->
        @show_menu = false

      back: ->
        @$router.go -1

    computed:
      klass: ->
        return 'contextless' unless @current_context
        "with-context current-context-#{@current_context.slug}"

    watch:
      current_context: ->
        @choose_context = false
</script>
