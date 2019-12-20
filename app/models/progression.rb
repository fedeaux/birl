class Progression < ApplicationRecord
  belongs_to :context
  belongs_to :challenge
  belongs_to :exercise, optional: true
  has_many :session_progressions, dependent: :delete_all
  has_many :entries, dependent: :delete_all

  before_save :ensure_name

  delegate :name, :description, to: :challenge, prefix: :challenge

  def ensure_name
    self.name = [exercise&.name, challenge.name].reject(&:nil?).join ' - '
  end

  def exercise_name
    return nil unless name

    name.split('-').first.strip
  end

  def done_today
    last_entry_at && last_entry_at > 12.hours.ago
  end

  def update_last_entry_at
    update last_entry_at: entries.maximum(:created_at)
  end

  def base_entry_data_model
    return challenge.entry_data_model if challenge

    {
      dimensions: [
        { name: :reps, options: {} },
        { name: :weight, options: {} },
        { name: :rest, options: {} },
      ]
    }
  end

  def entry_data_model
    base_entry_data_model.deep_merge override_entry_data_model
  end
end
