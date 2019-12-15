class Context < ApplicationRecord
  belongs_to :user

  has_many :groups, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :progressions, dependent: :destroy
  has_many :trainings, dependent: :destroy
end
