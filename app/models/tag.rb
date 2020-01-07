class Tag < ApplicationRecord
  belongs_to :user
  has_ancestry

  before_save :sanitize_name
  before_save :set_names
  has_many :tag_taggables, dependent: :destroy
  has_many :taggables, through: :taggables
  default_scope ->{ order(:fullname) }

  def sanitize_name
    self.name = self.name.parameterize
  end

  def set_names
    self.parents_names = ancestors.map(&:name)
    self.fullname = (parents_names + [name]).join ':'
  end
end
