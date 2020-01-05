import BaseResource from './base_resource'
import Tag from '../models/tag'

class TagsResource extends BaseResource
  @model = -> Tag

export default TagsResource
