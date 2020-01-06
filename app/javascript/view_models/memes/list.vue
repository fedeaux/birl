<template lang="pug">
.entity-list.meme-list.default-container
  memes-list-item(v-for='meme in memes'
                  v-if='memes'
                  :meme='meme'
                  :allow_actions='allow_actions'
                  :key='meme.id'
                  @edit='$emit("edit", { meme: meme })'
                  @destroy='$emit("destroy", { meme: meme })')

  entity-list-empty(v-if='!memes || memes.length == 0')
</template>

<script lang="coffee">
export default
  props:
    allow_actions:
      default: false

    memes:
      default: null
</script>
