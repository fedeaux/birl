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
      statistics_by_tag_id = {}

      timelogs.each do |timelog|
        map_key = timelog.main_tag_id
        next unless map_key

        statistics_by_tag_id[map_key] ||= TimelogCollectionStatistics.new(days: 1)

        collection = statistics_by_tag_id[map_key]
        collection.add Statistics::TimelogStatistics.new timelog
      end

      statistics_by_tag_id.map { |tag_id, collection| { values: collection.tap(&:calculate).as_json, tag: Tag.find(tag_id) } }
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
