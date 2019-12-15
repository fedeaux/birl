class Group < ApplicationRecord
  belongs_to :context
  has_many :exercises, dependent: :destroy
end
