after(:contexts) do
  context = User.first.context 'music-sing'

  entry_data_model = EntryDataModel::Technique.new.entry_data_model

  training = Training.where(name: 'Sing', context_id: context.id).first_or_create
  session = Session.where(name: 'Drills', training_id: training.id, weekday: 0).first_or_create
  challenge = Challenge.where(name: 'Drills Cycle', context_id: context.id).first_or_create
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
end
