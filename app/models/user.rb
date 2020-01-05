class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contexts
  has_many :tags
  belongs_to :current_context, class_name: 'Context', optional: true

  def context(slug)
    contexts.find_by(slug: slug)
  end
end
