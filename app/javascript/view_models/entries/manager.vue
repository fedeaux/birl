<template lang="pug">
.entries-manager.flex-column
  //- BrainDamage: ManagerHead Start
  entries-generator(:context='context'
                    :data_model='data_model'
                    :entries='entries'
                    ref='entries_generator')
  //- BrainDamage: ManagerHead End

  .entity-manager-form.flex-item-fixed(v-if='form_entry')
    entries-form(v-model='form_entry'
                 :data_model='data_model'
                 :actions='actions.form'
                 @save='saveFormEntry()'
                 @cancel='clearFormEntry()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1(v-if='actions.add')
      .ui.primary.action-block-button.small.icon.button(@click='newEntry')
        i.plus.icon
        |  Add Entry

    .flex-column
      entries-list.flex-item(:entries='entries'
                             :allow_actions='true'
                             @edit='editEntry($event)'
                             @destroy='destroyEntry($event)')
</template>

<script lang="coffee">
import EntriesManagerMixin from '../../mixins/entries/manager'
import EntryValueSet from '../../models/entry_value_set'

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
