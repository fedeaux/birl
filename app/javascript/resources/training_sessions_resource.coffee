import BaseResource from './base_resource'
import TrainingSession from '../models/training_session'

class TrainingSessionsResource extends BaseResource
  @model = -> TrainingSession

export default TrainingSessionsResource
