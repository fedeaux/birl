import BaseResource from './base_resource'
import Goal from '../models/goal'

class GoalsResource extends BaseResource
  @model = -> Goal

export default GoalsResource
