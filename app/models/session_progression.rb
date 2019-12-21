class SessionProgression < ApplicationRecord
  belongs_to :session
  belongs_to :progression

  def name
    progression.name
  end
end
