class Group < ApplicationRecord
  belongs_to :user
  has_many :exercises
end

# NO-OVERRIDE
