# coding: utf-8
after(:challenges) do
  return

  # user = User.find_by(email: 'phec06@gmail.com')

  # progressions_attributes = [
  #   ['Abdominal Dragão', 'Destruição'],

  #   ['Abdominal Prancha', '5/4/3/2/1'],
  #   ['Abdominal Prancha', 'Resistência de Força'],

  #   ['Agachamento', '5/4/3/2/1'],
  #   ['Agachamento', 'Profilático'],

  #   ['Supino Reto', '5/4/3/2/1'],
  #   ['Supino Reto', 'Resistência de Força'],
  #   ['Supino Reto', 'Força'],

  #   ['Supino Inclinado', '5/4/3/2/1'],
  #   ['Supino Inclinado', 'Resistência de Força'],

  #   ['Supino Declinado', '5/4/3/2/1'],
  #   ['Supino Declinado', 'Resistência de Força']
  # ]

  # progressions_attributes.each do |progression_attributes|
  #   exercise = Exercise.find_by(user_id: user.id, name: progression_attributes[0])
  #   challenge = Challenge.find_by(user_id: user.id, name: progression_attributes[1])

  #   Progression.where(exercise: exercise,
  #                     challenge: challenge,
  #                     user_id: user.id).first_or_create
  # end
end
