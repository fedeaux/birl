import BaseResource from './base_resource'
import GoalEntry from '../models/goal_entry'

class GoalEntriesResource extends BaseResource
  @model = -> GoalEntry

export default GoalEntriesResource
