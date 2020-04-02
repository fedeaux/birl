<template lang="pug">
.statistics.padded-2(v-if='days')
  h1 Weeks
  statistics-line(:day='day' :base=86400 v-for='day in days')
  hr
  h1 Days
  statistics-line(:day='day' :base=86400 v-for='day in days')
</template>

<script lang="coffee">
import DaysManagerMixin from '../../mixins/days/manager'

export default
  mixins: [DaysManagerMixin]
</script>
