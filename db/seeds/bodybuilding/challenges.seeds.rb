after('bodybuilding:exercises') do
  challenge_ids = []

  User.find_each do |user|
    context = user.context 'bodybuilding'
    next unless context

    [
      {
        name: '5/4/3/2/1',
        description: '2-4 na primeira, 20-25 na quinta',
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
        name: 'Constante',
        description: 'Encontre uma velocidade que aguente 5min e vá subindo o tempo e a velocidade',
        data_model: EntryDataModel::TreadmillHiit
      },
      {
        name: 'Isometria',
        description: '',
        data_model: EntryDataModel::Isometry
      },
      {
        name: 'HIIT (leve)',
        description: '',
        data_model: EntryDataModel::Hiit
      },
      {
        name: 'HIIT sem peso',
        description: '',
        data_model: EntryDataModel::WeightlessHiit
      },
      {
        name: 'Movimento',
        description: '',
        data_model: EntryDataModel::RawTime
      }
    ].each do |challenge_attrs|
      challenge = context.challenges.find_or_initialize_by(name: challenge_attrs[:name])

      challenge_attrs[:entry_data_model] = (challenge_attrs[:data_model] || EntryDataModel::MaxRepetitions).new.entry_data_model

      challenge.assign_attributes challenge_attrs.except(:data_model)
      challenge.save
      challenge_ids.push challenge.id
    end
  end
end
