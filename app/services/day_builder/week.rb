module DayBuilder
  class Week
    attr_reader :user
    attr_accessor :options

    def initialize(user, options = {})
      @user = user
      @options = options
    end

    def build
      start_day = @options.key?(:start) ? DateTime.parse(@options[:start]) : user.start_of_week
      final_day = start_day + 7.days
      current_day = start_day.dup.beginning_of_day
      sleep_deviation_correction = 120
      midnight_offset = 0

      while current_day != final_day
        TimeTable.build(current_day, user) do |time_table|
          # Pre-adjustments
          # 6 is saturday
          work_tag = case current_day.wday
                     when 1..5
                       'work:runa:squad_ron'
                     else
                       'projects:birl'
                     end

          fill_start_day_tag = case current_day.wday
                               when 1
                                 'work:runa:squad_ron'
                               when 2..5
                                 'projects:birl'
                               else
                                 nil
                               end

          fill_end_day_tag = case current_day.wday
                             when 0
                               'work:runa:squad_ron'
                             when 1..4
                               'projects:birl'
                             else
                               nil
                             end

          # Times
          if sleep_deviation_correction > 0
            time_table.timelog(tag: fill_start_day_tag,
                               duration: "#{sleep_deviation_correction}min")
          end

          time_table.timelog(duration: '1h30min',
                             tag: 'study:lightless')

          time_table.timelog(duration: '8h30min',
                             tag: 'life:sleep')

          time_table.skip '30min'

          time_table.timelog(duration: '3h30min',
                             tag: work_tag)

          time_table.timelog(duration: '2h',
                             tag: 'progressions:home_training')

          time_table.timelog(duration: '3h30min',
                             tag: work_tag)

          time_table.timelog(duration: '1h30min',
                             tag: 'chores:prepare_for_tomorrow')

          time_table.timelog(finish: '00:00',
                             tag: fill_end_day_tag) if fill_end_day_tag

          sleep_deviation_correction -= 30 if sleep_deviation_correction > midnight_offset
        end

        current_day = (current_day.dup + 1.day).beginning_of_day
      end
    end
  end
end
