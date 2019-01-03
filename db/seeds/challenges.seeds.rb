# coding: utf-8
after(:exercises) do
  user = User.first

  [
    {
      id: 1, name: '5/4/3/2/1',
      description: '2-4 na primeira, 20-25 na quinta'
    },
    {
      id: 2, name: 'Resistência de Força',
      description: '6-12 nas duas primeiras, 12-20 nas próximas duas'
    },
    {
      id: 3, name: 'Força',
      description: '4-8 nas quatro'
    },
    {
      id: 4, name: 'Profilático',
      description:''
    },
    {
      id: 5, name: 'Destruição',
      description: '4 séries com pouco descanso (10-30s), um peso maior na primeira série e menor nas demais'
    },
    {
      id: 6, name: 'HIIT 40s/20s',
      description: 'Find a speed for 10 sprints, increase speed and sprints one by one, up to 20 sprints of maximum speed'
    },
    {
      id: 7, name: '12min constant',
      description: 'Find a speed for 10min, increase speed and minutes one by one, up to 20min of maximum speed'
    },
    {
      id: 8, name: 'Resistência de Força (ultraleve)',
      description: '5 séries. 30 na primeira. Falling star: 30 25 21 18 15'
    }
  ].each do |challenge_attrs|
    challenge = Challenge.find_or_initialize_by(id: challenge_attrs[:id])
    challenge.assign_attributes challenge_attrs.merge(user: user)
    challenge.save
  end
end
