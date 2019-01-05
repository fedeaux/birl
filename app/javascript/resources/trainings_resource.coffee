import BaseResource from './base_resource'
import Training from '../models/training'

class TrainingsResource extends BaseResource
  @model = -> Training

export default TrainingsResource
