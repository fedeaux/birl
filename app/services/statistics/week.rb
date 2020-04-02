module Statistics
  class Week
    def self.calculate
      ::Week.pluck(:id).each do |week_id|
        new(week_id: week_id).save!
      end
    end

    def initialize(week_id: nil)
      @week = ::Week.find week_id
      @start = @week.start
      @finish = @week.finish
    end

    def timelogs_statistics
      statistics_by_tag_id = {}

      @week.days.each do |day|
        day.meta['statistics']['timelogs'].each do |timelogs_statistics_item|
          tag_id = timelogs_statistics_item['tag']['id']

          statistics_by_tag_id[tag_id] ||= TimelogCollectionStatistics.new
          collection = statistics_by_tag_id[tag_id]
          collection.merge TimelogCollectionStatistics.new timelogs_statistics_item['values'].deep_symbolize_keys
        end
      end

      statistics_by_tag_id.map { |tag_id, collection| { values: collection.tap(&:calculate).as_json, tag: Tag.find(tag_id) } }
    end

    def save!
      statistics = {
        timelogs: timelogs_statistics
      }

      @week.meta[:statistics] = statistics
      @week.save
    end
  end
end
