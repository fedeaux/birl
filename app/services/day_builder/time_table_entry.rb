module DayBuilder
  class TimeTableEntry
    attr_reader :user, :start, :description
    attr_accessor :duration
    attr_writer :finish

    def initialize(params = {})
      @duration = params[:duration]
      @finish = params[:finish]
      @description = params[:description]
      @start = params[:start]
      @tag_fullname = params[:tag]

      @user = params[:user]
    end

    def self.duration_in_days(duration)
      hours = duration.scan(/(\d+)h/).first&.first.to_i || 0
      minutes = duration.scan(/(\d+)min/).first&.first.to_i || 0

      hours.hours + minutes.minutes
    end

    def duration_in_days
      @duration_in_days ||= TimeTableEntry.duration_in_days @duration
    end

    def finish
      return start + duration_in_days unless @finish

      candidate = TimeTableEntry.time_in start, @finish

      # finish 00:00 hot fix
      return candidate + 1.day if @finish == '00:00'

      candidate
    end

    def tag
      @tag ||= @user.tags.find_by(fullname: @tag_fullname)
    end

    def timelog_params
      {
        start: start,
        finish: finish,
        description: description,
        main_tag: tag,
        user: user,
        day: day,
        meta: { day_built: true }
      }
    end

    def day
      @day ||= TimeTableEntry.day(user)
    end

    def self.time_in(base_date, timestamp)
      parts = timestamp.split ':'
      base_date.clone.change(hour: parts[0].to_i, min: parts[1].to_i, sec: 0)
    end

    def self.day(user)
      ::Day.ensure user
    end

    def self.build(start_of_day, user)
      return [] if day(user).planned?

      # First thing in the morning
      cook = new(start: start_of_day,
                            duration: '1h30min',
                            tag: 'chores:cook',
                            description: '(and meditate)',
                            user: user
                           )
      entries = [cook]

      # first meal
      entries.push new(start: cook.finish - 20.minutes,
                       duration: '10min',
                       tag: 'life:eat',
                       user: user)

      first_runa = new(start: cook.finish,
                       duration: '4h',
                       tag: 'work:runa:squad_ron',
                       user: user)

      entries.push first_runa

      if first_runa.finish > time_in(start_of_day, '16:00')
        first_runa.finish = '16:00'
      end

      # second meal
      entries.push new(start: first_runa.finish - 1.hour,
                       duration: '10min',
                       tag: 'life:eat',
                       user: user)

      # training
      training = new(duration: '2h',
                     start: first_runa.finish,
                     tag: 'progressions:home_training',
                     user: user)

      entries.push training

      second_runa = new(start: training.finish,
                        finish: '19:00',
                        tag: 'work:runa:squad_ron',
                        user: user)

      entries.push second_runa

      # third meal
      entries.push new(start: second_runa.start + 1.hour,
                       duration: '10min',
                       tag: 'life:eat',
                       user: user)

      # last meal
      entries.push new(start: time_in(start_of_day, '22:20'),
                       duration: '10min',
                       tag: 'life:eat',
                       user: user)

      entries.sort_by(&:start)
    end
  end
end

# chores:acyclic
# chores:cook
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
