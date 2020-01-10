import BaseResource from './base_resource'
import TagTaggable from '../models/tag_taggable'

class TagTaggablesResource extends BaseResource
  @model = -> TagTaggable

  batchEnsureTags: (data, success) ->
    $.ajax
      type: 'POST'
      url: @collectionUrl('/batch_ensure_tags')
      data: data
      success: success

export default TagTaggablesResource
