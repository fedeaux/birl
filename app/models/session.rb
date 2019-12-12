class Session < ApplicationRecord
  belongs_to :training
  has_many :session_progressions, dependent: :destroy
  has_many :progressions, ->{ order(:order) }, through: :session_progressions
end
