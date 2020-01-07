import BaseResource from './base_resource'
import TagTaggable from '../models/tag_taggable'

class TagTaggablesResource extends BaseResource
  @model = -> TagTaggable

export default TagTaggablesResource
