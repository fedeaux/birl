<template lang="pug">
.<%= plural_dash_name %>-manager.flex-column
<%= sub_template('ManagerHead', '//-', 2) %>

  .entity-manager-form.flex-item-fixed(v-if='form_<%= underscore_name %>')
    <%= plural_dash_name %>-form(v-model='form_<%= underscore_name %>'
    <%= plural_dash_name_as_spaces %>      @save='saveForm<%= entity_name %>()'
    <%= plural_dash_name_as_spaces %>      @cancel='clearForm<%= entity_name %>()')

  template(v-else)
    .flex-item-fixed.action-block.b-padded-1
      .ui.primary.action-block-button.small.icon.button(@click='new<%= entity_name %>')
        i.plus.icon
        |  Add <%= human_name %>

    .flex-column
      <%= plural_dash_name %>-list.flex-item(:<%= plural_underscore_name %>='<%= plural_underscore_name %>'
      <%= plural_dash_name_as_spaces %>                :allow_actions='true'
      <%= plural_dash_name_as_spaces %>                @edit='edit<%= entity_name %>($event)'
      <%= plural_dash_name_as_spaces %>                @destroy='destroy<%= entity_name %>($event)')
</template>

<script lang="coffee">
import <%= plural_entity_name %>ManagerMixin from '../../mixins/<%= plural_underscore_name %>/manager'

export default
  mixins: [<%= plural_entity_name %>ManagerMixin]

<%= sub_template('Other', '#', 2) %>

</script>
