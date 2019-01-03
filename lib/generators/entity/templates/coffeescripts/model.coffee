import BaseModel from './base_model'

class <%= entity_name %> extends BaseModel
  @collection = '<%= plural_underscore_name %>'
  @member = '<%= underscore_name %>'
  @class_name = '<%= entity_name %>'

  @attributes = ->
    {
      id: {}
<%= attributes_as_front_model_list %>
    }

export default <%= entity_name %>
