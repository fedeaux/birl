class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  belongs_to :exercise
  has_many :session_progressions, dependent: :destroy
  has_many :sessions, through: :session_progressions
end
