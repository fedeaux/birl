import BaseResource from './base_resource'
import GoalsPeriod from '../models/goals_period'

export default class GoalsPeriodsResource extends BaseResource
  @model = -> GoalsPeriod
