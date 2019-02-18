class Entry < ApplicationRecord
  belongs_to :progression, counter_cache: true
  before_save :copy_progression_details

  def copy_progression_details
    return if self.variables
    self.variables = progression.details
  end
end
