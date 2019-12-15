class Training < ApplicationRecord
  belongs_to :context
  has_many :sessions
end
