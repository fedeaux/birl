class Tag < ApplicationRecord
  belongs_to :user
  has_ancestry
end
