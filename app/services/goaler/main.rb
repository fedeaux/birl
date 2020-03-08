module Goaler
  class Main
    attr_reader :user

    def initialize(user, options)
      @user = user
      @options = options
      @options[:base_date] = user.in_time_zone DateTime.parse options[:base_date]
    end

    def build
      {
        goals_periods: [
          goals_period_yesterday,
          goals_period_today
        ]
      }
    end

    def goals_period_today
      {
        name: 'Today',
        items: @user.goals.map { |goal| goal.ensure_entry(@options) }
      }
    end

    def goals_period_yesterday
      options = @options.deep_dup
      options[:base_date] = @options[:base_date] - 1.day

      {
        name: 'Yesterday',
        items: @user.goals.map { |goal| goal.ensure_entry(options) }
      }
    end
  end
end
