module DayBuilder
  class TimeTableEntry
    def initialize(params = {})
      @duration = params[:duration]
      @user = params[:user]
      @tag_fullname = params[:tag]
    end

    def duration_in_days
      unless @duration_in_days
        hours = @duration.scan(/(\d+)h/).first&.first.to_i || 0
        minutes = @duration.scan(/(\d+)min/).first&.first.to_i || 0

        @duration_in_days = hours.hours + minutes.minutes
      end

      @duration_in_days
    end

    def tag
      @tag ||= @user.tags.find_by(fullname: @tag_fullname)
    end
  end
end
