<template lang="pug">
.statistics.padded-2.scroll-y(v-if='days')
  h1 Weeks
  statistics-bars(:statiscables='weeks' :base=604800 v-if='weeks')
  hr
  //- h1 Days
  //- statistics-line(:statiscable='day' :base=86400 v-for='day in days')
</template>

<script lang="coffee">
import DaysManagerMixin from '../../mixins/days/manager'
import WeeksManagerMixin from '../../mixins/weeks/manager'

export default
  mixins: [DaysManagerMixin, WeeksManagerMixin]
</script>
