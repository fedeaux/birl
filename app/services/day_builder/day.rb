module DayBuilder
  class Day
    attr_reader :user
    attr_accessor :options

    def initialize(user, options = {})
      @user = user
      @options = options
    end

    def build
      return if TimeTableEntry.day(user).planned?

      start = @options.key?(:start) ? DateTime.parse(@options[:start]) : user.time_now

      TimeTableEntry.build(start, user).each do |entry|
        Timelog.create(entry.timelog_params)
      end
    end

    def remove
    end
  end
end
