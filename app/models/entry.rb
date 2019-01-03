class Entry < ApplicationRecord
  belongs_to :progression
  default_scope { order('updated_at DESC') }

  before_create :copy_progression_variables
  after_create :touch_progression

  def copy_progression_variables
    self.variables = progression.variables
  end

  def touch_progression
    self.progression.update_columns(last_entry_at: created_at)
  end
end
