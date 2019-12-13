class Challenge < ApplicationRecord
  belongs_to :user
  has_many :progressions, dependent: :destroy
end
