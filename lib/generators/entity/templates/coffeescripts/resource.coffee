import BaseResource from './base_resource'
import <%= entity_name %> from '../models/<%= underscore_name %>'

class <%= plural_entity_name %>Resource extends BaseResource
  @model = -> <%= entity_name %>

export default <%= plural_entity_name %>Resource
