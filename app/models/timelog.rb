class Timelog < ApplicationRecord
  belongs_to :day, optional: true
  belongs_to :user
  has_many :tag_taggables, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_taggables

  before_save :ensure_day
  after_save :save_main_tag

  scope :in_range, ->(from, to) {
    where('(start > :from AND start < :to) OR (finish > :from AND finish < :to)', from: from, to: to)
  }

  def duration(as: :seconds)
    (finish - start).send(as)
  end

  def main_tag
    tag_taggables.find_by("meta->>'main' = ?", true.to_json)&.tag
  end

  def main_tag_id
    main_tag&.id
  end

  def main_tag=(main_tag_params)
    @main_tag = if main_tag_params.nil? || main_tag_params.is_a?(Tag)
                  main_tag_params
                else
                  Tag.find(main_tag_params[:id])
                end
  end

  def save_main_tag
    return unless @main_tag && @main_tag.id != main_tag&.id

    tag_taggables.destroy_all
    TagTaggable.create(taggable: self, tag_id: @main_tag.id, meta: { main: true })
  end

  def ensure_day
    self.day ||= Day.ensure(user, date: start)
  end

  def reeval_day!
    self.day = Day.ensure(user, date: start)
    save!
  end
end
