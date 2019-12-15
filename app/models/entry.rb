class Entry < ApplicationRecord
  belongs_to :progression, counter_cache: true, touch: true
  before_save :copy_progression_details
  after_commit :update_progression_last_entry_at

  def copy_progression_details
    return if variables

    self.variables = progression.details
  end

  def update_progression_last_entry_at
    progression.update_last_entry_at
  end
end
