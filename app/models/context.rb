class Context < ApplicationRecord
  belongs_to :user

  has_many :groups, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :challenges, dependent: :destroy
  has_many :progressions, dependent: :destroy
  has_many :trainings, dependent: :destroy
  has_many :entries, through: :progressions

  def current_training
    trainings.last
  end

  def current_sessions
    current_training.sessions
  end

  def todays_weekday_in_timezone
    user.time_now.wday
  end

  def sessions_on_this_weekday
    current_sessions.where(weekday: todays_weekday_in_timezone)
  end

  def recurrence_scheme_groups
    Context.first.current_sessions.pluck(:recurrence_scheme).map { |rs| rs['group'] }.uniq
  end

  def oldest_recurrence_scheme_sequence_in_group(recurrence_scheme_group)
    current_sessions
      .where("recurrence_scheme->'group' = ?", recurrence_scheme_group.to_json)
      .order(:executed_at, "recurrence_scheme->'sequence' DESC")
      .limit(1)
      .first
      .recurrence_scheme['sequence']
  end

  def next_session_on_recurrence_scheme_group(recurrence_scheme_group)
    sessions = current_sessions.where("recurrence_scheme->'group' = ?", recurrence_scheme_group.to_json)

    # return nil if sessions.select(&:done_today?).any?

    oldest_recurrence_scheme_sequence = oldest_recurrence_scheme_sequence_in_group recurrence_scheme_group

    next_in_sequence = sessions
                         .where("recurrence_scheme->'sequence' = ?", (oldest_recurrence_scheme_sequence + 1).to_json)
                         .first

    next_in_sequence || sessions
                          .where("recurrence_scheme->'sequence' = ?", 0.to_json).first
  end

  # def next_sessions
  #   recurrence_scheme_groups.map do |recurrence_scheme_group|
  #     next_session_on_recurrence_scheme_group(recurrence_scheme_group)
  #   end.compact
  # end

  def next_sessions
    current_sessions.where("recurrence_scheme->'weekday' = ?", todays_weekday_in_timezone.to_json)
  end

  def todays_things
    todays_things = { context: self }

    if slug == 'music'
      todays_things[:progressions] = progressions.where(name: 'Guitar Basics')
    elsif slug == 'bodybuilding'
      todays_things[:sessions] = next_sessions
    # elsif slug == 'espanol'
    #   todays_things[:raw_links] = [{ name: 'Questioner', path: '/questioner' }]
    end

    todays_things
  end

  def dynamic_css
    ".current-context-#{slug} .context-dependent-background-color, .current-context-#{slug} .ui.primary.button, .current-context-#{slug} ::-webkit-scrollbar-thumb { background-color: #{color} !important }"
  end
end
