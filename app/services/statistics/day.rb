module Statistics
  class Day
    def self.calculate
      ::Day.pluck(:id).each do |day_id|
        new(day_id: day_id).save!
      end
    end

    def initialize(day_id: nil)
      @day = ::Day.find day_id
      @start = @day.start
      @finish = @day.finish
    end

    def timelogs
      @day.timelogs
    end

    def timelogs_statistics
      map = {}

      timelogs.each do |timelog|
        map_key = timelog.main_tag_id
        next unless map_key

        map[map_key] ||= TimelogCollectionStatistics.new(days: 1)

        collection = map[map_key]
        collection.add Statistics::TimelogStatistics.new timelog
      end

      map.map { |key, collection| [key, collection.tap(&:calculate).as_json] }.to_h
    end

    def save!
      statistics = {
        timelogs: timelogs_statistics
      }

      @day.meta[:statistics] = statistics
      @day.save
    end
  end
end
