after(:contexts) do
  context = User.first.context 'music'
  training = Training.where(name: 'Basics', context_id: context.id).first_or_create

  entry_data_model = EntryDataModel::Technique.new.entry_data_model
  session = Session.where(name: 'Sing', training_id: training.id, weekday: 0).first_or_create
  challenge = Challenge.where(name: 'Sing Basics', context_id: context.id).first_or_create
  challenge.update entry_data_model: entry_data_model
  progression = Progression.where(challenge_id: challenge.id, context_id: context.id).first_or_create

  progression.update(override_entry_data_model: {
                       generator: {
                         name: :sing_drills_cycle
                       },

                       label: [
                         { value: 'Sing' },
                         { value: 'Sustain Note' },
                         { value: 'Vocalises' }
                       ]
                     })

  SessionProgression.where(progression_id: progression.id, session_id: session.id, order: 0).first_or_create

  entry_data_model = EntryDataModel::MetronomeGroup.new.entry_data_model
  training = Training.where(name: 'Basics', context_id: context.id).first_or_create
  session = Session.where(name: 'Guitar', training_id: training.id, weekday: 0).first_or_create
  challenge = Challenge.where(name: 'Guitar Basics', context_id: context.id).first_or_create
  challenge.update entry_data_model: entry_data_model
  progression = Progression.where(challenge_id: challenge.id, context_id: context.id).first_or_create

  progression.update(override_entry_data_model: {
                       generator: {
                         name: :x_cromatisms
                       }
                     })

  SessionProgression.where(progression_id: progression.id, session_id: session.id, order: 0).first_or_create
end
