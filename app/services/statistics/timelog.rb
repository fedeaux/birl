module Statistics
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
