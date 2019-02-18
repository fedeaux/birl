class Progression < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  belongs_to :exercise
end
