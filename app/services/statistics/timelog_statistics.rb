module Statistics
  class TimelogStatistics < RecursiveOpenStruct
    def initialize(timelog)
      @timelog = timelog
      super @timelog.as_json(only: %i[start finish], methods: :duration)
    end
  end
end
