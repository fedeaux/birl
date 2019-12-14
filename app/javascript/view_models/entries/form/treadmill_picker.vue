<template lang="pug">
.entry-treadmill-picker
  .entry-treadmill-picker-item(v-for='(entry, index) in entries')

    .entry-treadmill-picker-item-dimension(v-for='dimension in dimensions' :class='classForDimension(dimension)')
      .ui.icon.basic.small.circular.button(@click='increase(index)')
        i.up.angle.icon

      input(type='text' :value='entry[dimension]')

      .ui.icon.basic.small.circular.button(@click='decrease(index)')
        i.down.angle.icon

    .ui.icon.red.tiny.circular.button.entry-treadmill-picker-remove-entry-button(@click='removeEntry(index)')
      i.minus.icon

  .ui.icon.primary.small.circular.button.treadmill-counter(@click='addEntry')
    i.plus.icon
</template>

<script lang="coffee">
  export default
    props:
      value: ''

    data: ->
      dimensions: ['sprints', 'time', 'unity', 'speed']
      entries: [
        {
          sprints: 10,
          time: 40,
          unity: 's',
          speed: 8.0
        },
        {
          sprints: 5,
          time: 40,
          unity: 's',
          speed: 7.0
        }
      ]

    methods:
      treadmillEntry: (sprints = 1, time = 10, unity = 's', speed = 8.0) ->
        sprints: sprints
        time: time
        unity: unity
        speed: speed

      classForDimension: (dimension) ->
        "entry-treadmill-picker-item-#{dimension}"

      addEntry: ->
        @entries.push @treadmillEntry()

      removeEntry: (index) ->
        @entries.splice(index, 1)

      increase: (index) ->
        value = parseInt @repetitions[index]
        Vue.set @repetitions, index, value + 0.1

      decrease: (index) ->
        value = parseInt @repetitions[index]
        Vue.set @repetitions, index, value - 0.1

    watch:
      entries:
        immediate: true
        handler: ->

      value:
        immediate: true
        handler: ->
</script>
