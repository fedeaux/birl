<template lang="pug">
.entity-manager.entries-manager.default-container
  //- BrainDamage: ManagerHead Start
  entries-generator(:context='context'
                    :data_model='data_model'
                    :entries='entries'
                    ref='entries_generator')
  //- BrainDamage: ManagerHead End

  .entity-manager-form(v-if='form_entry')
    entries-form(v-model='form_entry'
                 :data_model='data_model'
                 :actions='actions.form'
                 @save='saveFormEntry()'
                 @cancel='clearFormEntry()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed(v-if='actions.add')
      #new-entry-button.ui.primary.top.attached.fluid.small.icon.button(@click='newEntry')
        i.plus.icon
        |  Add Entry

    .flex-item
      entries-list(:entries='entries'
                   :allow_actions='true'
                   @edit='editEntry($event)'
                   @destroy='destroyEntry($event)')
</template>

<script lang="coffee">
import EntriesManagerMixin from '../../mixins/entries/manager'

export default
  mixins: [EntriesManagerMixin]

  # BrainDamage: Other Start
  props:
    actions:
      default: ->
        {
          list_actions: true,
          add: true,
          form: {
            save: true,
            cancel: true
          }
        }

    data_model:
      default: -> {}

  methods:
    entrySetUpdated: (data) ->
      Vue.set @form_entry.value.sets, data.index, new EntryValueSet data.set

    entryAddSet: ->
      @form_entry.value.sets.push @form_entry.value.newSet @data_model

    newEntry: ->
      @setFormEntry @$refs.entries_generator.generate()

    populateFormEntry: ->
      @setFormEntry @$refs.entries_generator.populate @form_entry
  # BrainDamage: Other End

</script>
