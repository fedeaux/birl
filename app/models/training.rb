class Training < ApplicationRecord
  belongs_to :user
  has_many :sessions
end
