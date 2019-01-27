# coding: utf-8
after(:challenges) do
  return
  user = User.find_by(email: 'phec06@gmail.com')

  training = user.trainings.where(name: 'The Awesome Training').first_or_create

  sessions_attributes = [
    {
      name: 'Push A',
      order: 1,
      progressions: [
        ['Agachamento', '5/4/3/2/1'],
        ['Supino Reto', '5/4/3/2/1'],
        ['Supino Inclinado', 'Resistência de Força'],
        ['Super Crucifixo & Supino', 'Destruição'],
        ['Elevação Lateral', 'Destruição'],
      ]
    },

    {
      name: 'Push B',
      order: 5,
      progressions: [
        ['Supino Declinado', '5/4/3/2/1'],
        ['Supino Reto', 'Resistência de Força'],
        ['Agachamento', 'Profilático'],
        ['Super Crossover', 'Destruição'],
        ['Elevação Lateral', 'Destruição'],
      ]
    },

    {
      name: 'Push C',
      order: 9,
      progressions: [
        ['Supino Reto', '5/4/3/2/1'],
        ['Supino Declinado', 'Resistência de Força'],
        ['Agachamento', 'Profilático'],
        ['Super Crucifixo & Supino', 'Destruição'],
        ['Elevação Lateral Polia', 'Destruição'],
      ]
    },

    {
      name: 'Push D',
      order: 13,
      progressions: [
        ['Supino Inclinado', '5/4/3/2/1'],
        ['Supino Reto', 'Resistência de Força'],
        ['Agachamento', 'Profilático'],
        ['Super Crossover', 'Destruição'],
        ['Elevação Lateral Polia', 'Destruição'],
      ]
    }
  ]

  sessions_attributes.each do |session_attributes|
    session_attributes[:progressions].each do |progression_attributes|
      exercise = Exercise.find_by(user_id: user.id, name: progression_attributes[0])
      challenge = Challenge.find_by(user_id: user.id, name: progression_attributes[1])
      Progression.where(exercise: exercise, challenge: challenge, user_id: user.id).first_or_create
    end
  end
end
