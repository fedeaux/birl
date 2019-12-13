class Entry < ApplicationRecord
  belongs_to :progression, counter_cache: true, touch: true
  before_save :copy_progression_details
  after_create :update_progression

  def copy_progression_details
    return if self.variables

    self.variables = progression.details
  end

  def update_progression
    progression.update(last_entry_at: Time.now)
  end
end
