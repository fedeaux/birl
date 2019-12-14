class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  belongs_to :exercise
  belongs_to :session_progression, touch: true, optional: true
  has_many :entries, dependent: :destroy

  before_save :ensure_name

  def ensure_name
    self.name = "#{exercise.name} - #{challenge.name}"
  end

  def exercise_name
    return nil unless name

    name.split('-').first.strip
  end

  def challenge_name
    return nil unless name

    name.split('-').last.strip
  end

  def done_today
    last_entry_at && last_entry_at > 12.hours.ago
  end

  def update_last_entry_at
    update last_entry_at: entries.maximum(:created_at)
  end
end
