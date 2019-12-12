class Exercise < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  has_many :progressions
  has_many :entries, through: :progressions
end
