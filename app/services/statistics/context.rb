# reload!; Statistics::Context.new(context_id: Context.first.id, start: DateTime.now.beginning_of_day, finish: DateTime.now.end_of_day).save_statistics

module Statistics
  class EntryStatistics < RecursiveOpenStruct
    def initialize(entry)
      @entry = entry
      super
    end
  end

  class EntryCollectionStatistics < RecursiveOpenStruct
    def initialize(start:, finish:)
      @start = start
      @finish = finish
      super(count: 0, mean_count: 0)
    end

    def add(_entry_statistics)
      self.count = count + 1
    end

    def calculate
      self.mean_count = (count / (@finish - @start)).round(2)
    end
  end

  class Context
    def initialize(context_id: nil, start: nil, finish: nil)
      @context = ::Context.find context_id
      @start = start
      @finish = finish
    end

    def entries
      @context.entries.in_range(@start, @finish)
    end

    def save_statistics
      collection = EntryCollectionStatistics.new(start: @start, finish: @finish)

      entries.each do |timelog|
        collection.add Statistics::EntryStatistics.new timelog
      end

      collection.tap(&:calculate)
    end
  end
end
