# coding: utf-8
after(:challenges) do
  user = User.find_by(email: 'phec06@gmail.com')

  training = Training.where(name: 'Adaptation', user: user).first_or_create

  session_attributes = [
    {
      name: 'Upper A',
      progressions: [
        { name: 'Supino Reto' },
        { name: 'Supino Inclinado' },
      ]
    },
    {
      name: 'Upper A',
      exercises: [
        { name: 'Supino Reto' },
        { name: 'Supino Inclinado' },
        { name: 'Supino Inclinado' },
      ]
    },
    {
      name: 'Upper A',
      exercises: [
        { id: 42, name: 'Supino Reto' },
        { id: 44, name: 'Supino Inclinado' },
        { id: 44, name: 'Supino Inclinado' },
      ]
    }
  ]
end
