import BaseModel from './base_model'


class Lister extends BaseModel
  @collection = 'listers'
  @member = 'lister'
  @class_name = 'Lister'

  @attributes = ->
    {
      id: {}
      name: {}
      values: {}
    }

export default Lister
