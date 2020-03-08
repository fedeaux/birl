after(:users) do
  user = User.find_by(email: 'phec06@gmail.com')

  [
    {
      name: 'Do not smoke weed after 21:00',
      type: 'YesOrNoGoal',
      recurrence_scheme: {
        type: 'every_day'
      }
    },
    {
      name: 'Work 5h on SquadRon',
      type: 'TimelogGoal',
      recurrence_scheme: {
        type: 'every_weekday',
        skip_weekends: true
      }
    }
  ].each do |goal_params|
    Goal.where(goal_params.slice(:name, :type).merge(user: user)).first_or_create.update(goal_params)
  end
end
