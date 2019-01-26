# coding: utf-8
after(:challenges) do
  user = User.find_by(email: 'phec06@gmail.com')

  training = user.trainings.where(name: 'Monstruous General Adaptation').first_or_create

  session_attributes = [
    {
      name: 'Push A',
      order: 1,
      progressions: [
        ['Supino Reto', '5/4/3/2/1'],
        ['Supino Inclinado', 'Resistência de Força'],
        ['Agachamento', 'Profilático'],
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

  session.attributes.each do
  end
end
