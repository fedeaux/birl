class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  belongs_to :exercise
  has_many :entries, dependent: :destroy

  before_save :ensure_name

  def ensure_name
    self.name = "#{exercise.name} - #{challenge.name}"
  end
end
