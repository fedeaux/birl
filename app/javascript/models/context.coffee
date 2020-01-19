import BaseModel from './base_model'
import User from './user'

class Context extends BaseModel
  @collection = 'contexts'
  @member = 'context'
  @class_name = 'Context'

  @attributes = ->
    {
      id: {}
      name: {}
      slug: {}
      color: {}
      meta: {}
    }

  backgroundColor: ->
    { "background-color": @color }

  cssStyle: ->
    "{ background-color: #{@color} !important }"

export default Context
