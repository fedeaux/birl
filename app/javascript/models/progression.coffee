import BaseModel from './base_model'
import Context from './context'
import Challenge from './challenge'
import Entry from './entry'
import Exercise from './exercise'

class Progression extends BaseModel
  @collection = 'progressions'
  @member = 'progression'
  @class_name = 'Progression'

  @attributes = ->
    {
      id: {}
      name: {}
      details: {}
      context: { type: Context }
      context_id: {}
      challenge: { type: Challenge }
      challenge_id: {}
      exercise: { type: Exercise }
      exercise_id: {}
      last_entry_at: { type: moment }
      entries_count: {}
      exercise_name: {}
      challenge_name: {}
      challenge_description: {}
      done_today: {}
      entry_data_model: {}
      entries: { type: Entry }
      new_entry: { type: Entry }
      todays_entry: { type: Entry }
    }

  executePath: ->
    "/#{@collection()}/#{@id}/execute"

export default Progression
