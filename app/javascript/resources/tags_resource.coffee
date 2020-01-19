import BaseResource from './base_resource'
import Tag from '../models/tag'

class TagsResource extends BaseResource
  @model = -> Tag

  hierarchy: (success, params = {}) ->
    $.ajax
      url: @collectionUrl '/hierarchy'
      type: 'get'
      data: params
      success: @collectionClosure(success)

  leaves: (success, params = {}) ->
    $.ajax
      url: @collectionUrl('/leaves')
      type: 'get'
      data: params
      success: @collectionClosure(success)

export default TagsResource
