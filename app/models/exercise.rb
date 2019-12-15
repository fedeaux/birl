class Exercise < ApplicationRecord
  belongs_to :context
  belongs_to :group, optional: true

  has_many :progressions
  has_many :entries, through: :progressions

  def group_name
    group&.name
  end
end
