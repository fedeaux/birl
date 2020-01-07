class Tag < ApplicationRecord
  belongs_to :user
  has_ancestry

  before_save :sanitize_name
  before_save :set_names
  before_save :ensure_colors
  has_many :tag_taggables, dependent: :destroy
  has_many :taggables, through: :taggables
  default_scope ->{ order(:fullname) }

  def color=(value)
    value = { hex: value } unless value.is_a? Hash
    super value
  end

  def background_color=(value)
    value = { hex: value } unless value.is_a? Hash
    super value
  end

  def sanitize_name
    self.name = self.name.parameterize
  end

  def set_names
    self.parents_names = ancestors.map(&:name)
    self.fullname = (parents_names + [name]).join ':'
  end

  def ensure_colors
    self.color = parent ? parent.color : '#fff' if color.blank?
    self.background_color = parent ? parent.background_color : '#000' if background_color.blank?
  end

  def copy_colors_to_descendants
    colors = attributes.slice('color', 'background_color')

    descendants.each do |tag|
      tag.update colors
    end
  end
end
