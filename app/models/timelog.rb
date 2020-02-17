class Timelog < ApplicationRecord
  belongs_to :user
  has_many :tag_taggables, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_taggables

  after_save :save_main_tag

  def main_tag
    tags.first
  end

  def main_tag=(main_tag_params)
    @main_tag = Tag.find(main_tag_params[:id])
  end

  def save_main_tag
    return unless @main_tag
    return if @main_tag.id == main_tag&.id

    tag_taggables.destroy_all
    TagTaggable.create(taggable: self, tag_id: @main_tag.id)
  end
end
