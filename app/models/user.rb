class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups
  has_many :exercises
  has_many :challenges
  has_many :progressions
  has_many :trainings

  def current_training
    trainings.first
  end
end
