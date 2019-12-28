import BaseResource from './base_resource'
import Vocabulary from '../models/vocabulary'

class VocabulariesResource extends BaseResource
  @model = -> Vocabulary

export default VocabulariesResource
