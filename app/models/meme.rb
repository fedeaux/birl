class Meme < ApplicationRecord
  belongs_to :user
  has_many :tag_taggables, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_taggables

  def tags=(tags_or_tags_attributes)
    tags_ids = if tags_or_tags_attributes.is_a? Array
                 tags_or_tags_attributes.each do |tag|
                   tag_taggables.where(tag_id: tag.id).first_or_create
                 end

                 tags_or_tags_attributes.map(&:id)
               else
                 self.tags_by_attributes tags_or_tags_attributes
               end

    tag_taggables.where('tag_id NOT IN (?)', tags_ids).destroy_all
  end

  def tags_by_attributes(tags_attrs)
    tags_attrs = tags_attrs.to_h.deep_symbolize_keys

    tags_attrs.values.map do |tag_attrs|
      tag_taggables.where(tag_id: tag_attrs[:id]).first_or_create
      tag_attrs[:id]
    end
  end

  def tag_id=(_param); end
end
