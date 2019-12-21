import BaseResource from './base_resource'
import Lister from '../models/lister'

class ListersResource extends BaseResource
  @model = -> Lister

export default ListersResource
