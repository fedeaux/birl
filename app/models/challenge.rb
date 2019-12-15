class Challenge < ApplicationRecord
  belongs_to :context
  has_many :progressions, dependent: :destroy
end
