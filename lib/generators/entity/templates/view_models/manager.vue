<template lang="pug">
.entity-manager.<%= plural_dash_name %>-manager.default-container
<%= sub_template('ManagerHead', '//-', 2) %>

  .entity-manager-form(v-if='form_<%= underscore_name %>')
    <%= plural_dash_name %>-form(v-model='form_<%= underscore_name %>'
    <%= plural_dash_name_as_spaces %>      @save='saveForm<%= entity_name %>()'
    <%= plural_dash_name_as_spaces %>      @cancel='clearForm<%= entity_name %>()')

  .entity-manager-list.flex-column(v-else)
    .entity-manager-list-header.flex-item-fixed
      #new-<%= dash_name %>-button.ui.primary.top.attached.fluid.small.icon.button(@click='new<%= entity_name %>')
        i.plus.icon
        |  Add <%= human_name %>

    .flex-item
      <%= plural_dash_name %>-list(:<%= plural_underscore_name %>='<%= plural_underscore_name %>'
      <%= plural_dash_name_as_spaces %>      :allow_actions='true'
      <%= plural_dash_name_as_spaces %>      @edit='edit<%= entity_name %>($event)'
      <%= plural_dash_name_as_spaces %>      @destroy='destroy<%= entity_name %>($event)')
</template>

<script lang="coffee">
import <%= plural_entity_name %>ManagerMixin from '../../mixins/<%= plural_underscore_name %>/manager'

export default
  mixins: [<%= plural_entity_name %>ManagerMixin]

<%= sub_template('Other', '#', 2) %>

</script>
