after(:contexts) do
  context = User.first.context 'meditation'

  entry_data_model = EntryDataModel::RawTime.new.entry_data_model

  training = Training.where(name: 'Meditation', context_id: context.id).first_or_create
  session = Session.where(name: 'Meditation', training_id: training.id, weekday: 0).first_or_create
  exercise = Exercise.where(name: 'Meditation', context_id: context.id).first_or_create
  challenge = Challenge.where(name: 'Focus on Breath', context_id: context.id, entry_data_model: entry_data_model).first_or_create
  progression = Progression.where(challenge_id: challenge.id, exercise_id: exercise.id, context_id: context.id).first_or_create

  SessionProgression.where(progression_id: progression.id, session_id: session.id, order: 0).first_or_create
end
