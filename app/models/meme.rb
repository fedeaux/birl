class Meme < ApplicationRecord
  belongs_to :user
  has_many :tag_taggables, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_taggables

  def tags=(tags_attributes)
    tags_attributes = tags_attributes.to_h.deep_symbolize_keys
    tags_ids = []

    tags_attributes.values.each do |tag_attributes|
      tag = tag_taggables.where(tag_id: tag_attributes[:id]).first_or_create
      tags_ids << tag_attributes[:id]
    end

    tag_taggables.where("tag_id NOT IN (?)", tags_ids).destroy_all
  end
end
