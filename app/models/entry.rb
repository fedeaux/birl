class Entry < ApplicationRecord
  VALUE_DIMENSIONS = %i[execution seconds weight reps rest speed bpmm]

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
           else
             []
           end

    param['sets'] = sets
    super param
  end
end
