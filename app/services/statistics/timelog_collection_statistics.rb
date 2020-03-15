module Statistics
  class TimelogCollectionStatistics < RecursiveOpenStruct
    def initialize(duration: 0, count: 0, days: 0,
                   mean_duration_by_count: 0, mean_duration_by_day: 0)

      super(duration: duration, count: count, days: days,
            mean_duration_by_count: mean_duration_by_count, mean_duration_by_day: mean_duration_by_day)
    end

    def add(timelog_statistics)
      self.count = count + 1
      self.duration = duration + timelog_statistics.duration
    end

    def calculate
      self.mean_duration_by_count = (duration.to_f / count).round unless count.zero?
      self.mean_duration_by_day = (duration.to_f / days).round unless days.zero?
    end
  end
end
