import BaseResource from './base_resource'
import Meme from '../models/meme'

class MemesResource extends BaseResource
  @model = -> Meme

export default MemesResource
