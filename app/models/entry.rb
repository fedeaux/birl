class Entry < ApplicationRecord
  VALUE_DIMENSIONS = %i[execution mult time weight reps speed bpmm rest pause]

  # Explanation
  # execution
  # mult
  # time
  # weight
  # reps
  # speed
  # bpmm
  # rest
  # pause

  belongs_to :progression, counter_cache: true, touch: true
  after_commit :update_progression_last_entry_at

  def update_progression_last_entry_at
    progression.update_last_entry_at
  end

  def value=(param)
    param = {} unless param.is_a? Hash
    sets = param['sets']

    sets = if sets.is_a? Hash
             sets.values
           elsif sets.is_a? Array
             sets
           else
             []
           end

    param['sets'] = sets
    super param
  end

  def prototype
    copy = clone
    copy.assign_attributes(created_at: nil, id: nil, updated_at: nil)
    copy
  end
end
