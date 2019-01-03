import BaseResource from './base_resource'
import Challenge from '../models/challenge'

class ChallengesResource extends BaseResource
  @model = -> Challenge

export default ChallengesResource
