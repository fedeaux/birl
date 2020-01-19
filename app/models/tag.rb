class Tag < ApplicationRecord
  belongs_to :user
  has_ancestry

  before_save :sanitize_name
  before_save :set_names
  before_save :ensure_colors
  has_many :tag_taggables, dependent: :destroy
  has_many :taggables, through: :taggables

  has_many :memes, through: :tag_taggables, source: :taggable, source_type: "Meme"

  default_scope ->{ order(:fullname) }

  scope :leaves, -> { joins("LEFT JOIN #{table_name} AS c ON c.#{ancestry_column} = CAST(#{table_name}.id AS char(50)) OR c.#{ancestry_column} = concat(#{table_name}.#{ancestry_column}, '/', #{table_name}.id)").group("#{table_name}.id").having('COUNT(c.id) = 0') }

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
