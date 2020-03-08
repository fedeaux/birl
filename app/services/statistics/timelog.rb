module Statistics
  class TimelogCollectionStatistics < RecursiveOpenStruct
    def initialize
      super(duration: 0, count: 0, days: 0,
            mean_duration_by_count: 0, mean_duration_by_day: 0)
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

  class TimelogStatistics < RecursiveOpenStruct
    def initialize(timelog)
      @timelog = timelog
      super @timelog.as_json(only: %i[start finish], methods: :duration)
    end
  end

  class Timelog
    def initialize(tag_id: nil, start: nil, finish: nil)
      @tag = Tag.find tag_id
      @start = start
      @finish = finish
    end

    def timelogs
      @tag.timelogs.in_range(@start, @finish)
    end

    def save_statistics
      @tag.children.each do |tag|
        self.class.new(tag_id: tag.id, start: @start, finish: @finish).save_statistics
      end

      collection = TimelogCollectionStatistics.new

      timelogs.each do |timelog|
        collection.add Statistics::TimelogStatistics.new timelog
      end

      collection.tap(&:calculate)
    end
  end
end
