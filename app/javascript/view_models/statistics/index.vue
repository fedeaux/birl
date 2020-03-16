<template lang="pug">
.statistics.padded-2(v-if='days')
  statistics-line(:day='day' :base=86400 v-for='day in days')
</template>

<script lang="coffee">
import DaysManagerMixin from '../../mixins/days/manager'

export default
  mixins: [DaysManagerMixin]
</script>
