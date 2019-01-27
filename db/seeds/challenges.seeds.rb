# coding: utf-8
after(:exercises) do
  User.find_each do |user|
    [
      {
        name: '5/4/3/2/1',
        description: '2-4 na primeira, 20-25 na quinta'
      },
      {
        name: 'Resistência de Força',
        description: '6-12 nas duas primeiras, 12-20 nas próximas duas'
      },
      {
        name: 'Força',
        description: '4-8 nas quatro'
      },
      {
        name: 'Profilático',
        description:''
      },
      {
        name: 'Destruição',
        description: '4 séries com pouco descanso (10-30s), um peso maior na primeira série e menor nas demais'
      },
      {
        name: 'HIIT 40s/20s',
        description: 'Find a speed for 10 sprints, increase speed and sprints one by one, up to 20 sprints of maximum speed'
      },
      {
        name: '12min constant',
        description: 'Find a speed for 10min, increase speed and minutes one by one, up to 20min of maximum speed'
      },
      {
        name: 'Resistência de Força (ultraleve)',
        description: '6 séries. Primeira mais pesada, 30 na segunda. Falling star: 4 30 25 21 18 15'
      },
    ].each do |challenge_attrs|
      challenge = user.challenges.find_or_initialize_by(name: challenge_attrs[:name])
      return if challenge.persisted?
      challenge.assign_attributes challenge_attrs
      challenge.save
    end
  end
end
