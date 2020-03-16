module DayBuilder
  class TimeTable
    attr_reader :user, :time_table_entries
    attr_accessor :current_date_time

    def initialize(day, user)
      @current_date_time = day.beginning_of_day
      @user = user
      @time_table_entries = []
    end

    def timelog(timelog_params)
      return skip timelog_params[:duration] unless timelog_params[:tag]

      timelog_params[:start] ||= current_date_time.dup
      timelog_params[:user] ||= @user

      time_table_entry = TimeTableEntry.new timelog_params
      self.current_date_time = time_table_entry.finish
      @time_table_entries.push time_table_entry
    end

    def skip(duration)
      self.current_date_time += TimeTableEntry.duration_in_days duration
    end

    def self.build(day, user)
      time_table = new(day, user)
      yield time_table

      time_table.time_table_entries.each do |time_table_entry|
        Timelog.create time_table_entry.timelog_params
      end
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
