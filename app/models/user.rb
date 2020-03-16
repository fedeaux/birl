class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :current_context, class_name: 'Context', optional: true

  has_many :contexts
  has_many :days
  has_many :goals
  has_many :memes
  has_many :timelogs

  has_many :tags
  has_many :tag_taggables, through: :tags

  def context(slug)
    contexts.find_by(slug: slug)
  end

  def time_now
    in_time_zone DateTime.now
  end

  def in_time_zone(date_time)
    date_time.in_time_zone(timezone)
  end

  def start_of_week
    (time_now + 1.week).beginning_of_week - 1.day
  end
end
