module DayBuilder
  class Day
    attr_reader :user
    attr_accessor :options

    def initialize(user, options = {})
      @user = user
      @options = options
    end

    def time_table
      [
        { duration: '1h30min', tag: 'chores:cook' },
        { duration: '3h30min', tag: 'work:runa:squad_ron' },

        { duration: '30min', tag: 'life:eat' },
        { duration: '1h30min', tag: 'progressions:home_training' },
        { duration: '2h', tag: 'work:runa:squad_ron' },

        { duration: '1h', tag: 'life:eat' },
        { duration: '2h', tag: 'work:runa:squad_ron' },
        { duration: '1h30min', tag: 'progressions:guitar' },
        { duration: '1h30min', tag: 'chores:cook' }
      ].map do |entry_params|
        TimeTableEntry.new entry_params.merge(user: user)
      end
    end

    def build
      @time_now = user.time_now
      @current_time = @time_now

      return if day.planned?

      time_table.each do |entry|
        start = @current_time

        Timelog.create(
          start: start,
          finish: start + entry.duration_in_days,
          main_tag: entry.tag,
          user: user,
          day: day
        )

        @current_time = start
      end
    end

    def day
      @day ||= ::Day.ensure user
    end
  end
end

# chores:acyclic
# chores:market
# chores:other
# life:beloveds
# life:eat
# life:f:f5
# life:f:fbb
# life:mornings
# life:sleep
# meditation
# progressions:guitar
# progressions:home_training
# projects:birl
# projects:brain-damage
# videos:fedeaux:identity
# videos:politics:bandido-bom
# videos:science:evolution
# work:runa:frontend_architecture
# work:runa:issues
# work:runa:meeting
# work:runa:other
# work:runa:qa_automation
# work:runa:squad_ron
