after('bodybuilding:exercises') do
  User.find_each do |user|
    [
      {
        name: '5/4/3/2/1',
        description: '2-4 na primeira, 20-25 na quinta',
        # entry_data_model: EntryDataModel::MaxRepetitions.new(reps_and_rests: [[2, 90], [4, 75], [7, 60], [10, 60], [12, 0]]).entry_data_model
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
        description: ''
      },
      {
        name: 'Destruição',
        description: '4 séries com pouco descanso (10-30s), um peso maior na primeira série e menor nas demais'
      },
      {
        name: 'Resistência de Força (ultraleve)',
        description: '6 séries. Primeira mais pesada, 30 na segunda. Falling star: 4 30 25 21 18 15'
      },
      {
        name: 'HIIT 40s/20s',
        description: 'Find a speed for 10 sprints, increase speed and sprints one by one, up to 20 sprints of maximum speed',
        data_model: EntryDataModel::TreadmillHiit
      },
      {
        name: 'Constant',
        description: 'Find a speed for 10min, increase speed and minutes one by one, up to 20min of maximum speed',
        data_model: EntryDataModel::TreadmillHiit
      },
      {
        name: 'Isometria',
        description: 'Stay still in position for some time',
        data_model: EntryDataModel::Isometry
      },
      {
        name: 'HIIT (leve)',
        description: '',
        data_model: EntryDataModel::Hiit
      }
    ].each do |challenge_attrs|
      context = user.context 'bodybuilding'
      next unless context

      challenge = context.challenges.find_or_initialize_by(name: challenge_attrs[:name])

      challenge_attrs[:entry_data_model] = (challenge_attrs[:data_model] || EntryDataModel::MaxRepetitions).new.entry_data_model

      challenge.assign_attributes challenge_attrs.except(:data_model)
      challenge.save
    end
  end
end
