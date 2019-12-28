import BaseModel from './base_model'


class Vocabulary extends BaseModel
  @collection = 'vocabularies'
  @member = 'vocabulary'
  @class_name = 'Vocabulary'

  @attributes = ->
    {
      id: {}
      es: {}
      pt_br: {}
      en: {}
      comment: {}
      kind: {}
      priority: {}
      meta: {}
    }

export default Vocabulary
