import BaseResource from './base_resource'
import Exercise from '../models/exercise'

class ExercisesResource extends BaseResource
  @model = -> Exercise

export default ExercisesResource
