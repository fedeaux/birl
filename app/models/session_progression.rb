class SessionProgression < ApplicationRecord
  belongs_to :session, touch: true
  belongs_to :progression, touch: true
end
