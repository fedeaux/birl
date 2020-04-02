module Statistics
  class TimelogStatistics < RecursiveOpenStruct
    def initialize(timelog)
      @timelog = timelog

      if @timelog.is_a? Hash
        super @timelog.deep_symbolize_keys
      else
        super @timelog.as_json(only: %i[start finish], methods: :duration)
      end
    end
  end
end
