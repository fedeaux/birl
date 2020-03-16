module Goaler
  class Main
    attr_reader :user

    def initialize(user, options)
      @user = user
      @options = options

      @options[:base_date] = if options[:base_date]
                               DateTime.parse options[:base_date]
                             else
                               DateTime.now
                             end
    end

    def build
      [
        goals_period_yesterday,
        goals_period_today,
        goals_period_ongoing
      ]
    end

    def goals_period_today
      RecursiveOpenStruct.new(
        name: 'Today',
        goal_entries: @user.goals.map { |goal| goal.ensure_entry(@options) }
      )
    end

    def goals_period_yesterday
      options = @options.deep_dup
      options[:base_date] = @options[:base_date] - 1.day

      RecursiveOpenStruct.new(
        name: 'Yesterday',
        goal_entries: @user.goals.map { |goal| goal.ensure_entry(options) }
      )
    end

    def goals_period_ongoing
      options = @options.deep_dup
      options[:base_date] = @options[:base_date] + 2.days

      RecursiveOpenStruct.new(
        name: 'Ongoing',
        goal_entries: @user.goals.map { |goal| goal.ensure_entry(options) }
      )
    end
  end
end
