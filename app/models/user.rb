class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :current_context, class_name: 'Context', optional: true
  has_many :contexts
  has_many :memes
  has_many :tags

  def context(slug)
    contexts.find_by(slug: slug)
  end
end
