after(:contexts) do
  return

  User.find_each do |user|
    [
      {
        group: 'Abdominal',
        exercises: [
          { name: 'Abdominal Dragão' },
          { name: 'Abdominal Polia' },
          { name: 'Abdominal Prancha' },
          { name: 'Abdominal Rodinha' },
          { name: 'Abdominal Vela' },
          { name: 'Abdominal Barra' },
          { name: 'Abdominal Barra Lateral' },
          { name: 'Abdominal Dragão Lateral' },
          { name: 'Obliquo Polia' },
          { name: 'Abdominal Canivete' }
        ]
      },

      {
        group: 'Perna',
        exercises: [
          { name: 'Agachamento' },
          { name: 'Stiff' },
          { name: 'Avanço Halter' },
          { name: 'Legpress' },
          { name: 'Cadeira Abdutora' },
          { name: 'Cadeira Adutora' },
          { name: 'Cadeira Extensora' },
          { name: 'Cadeira Flexora' }
        ]
      },

      {
        group: 'Peito',
        exercises: [
          { name: 'Cross Over Supra' },
          { name: 'Cross Over Meio' },
          { name: 'Cross Over Infra' },
          { name: 'Peck Deck' },
          { name: 'Pull Over' }
        ]
      },

      {
        group: 'Ombro',
        exercises: [
          { name: 'Arnold Press' },
          { name: 'Desenvolvimento Halter' },
          { name: 'Elevação Frontal' },
          { name: 'Elevação Lateral Polia' },
          { name: 'Elevação Lateral' },
          { name: 'Remada Alta' },
          { name: 'Segundo Tempo' }
        ]
      },

      {
        group: 'Trapézio',
        exercises: [
          { name: 'Trapézio Halter' }
        ]
      },

      {
        group: 'Lombar',
        exercises: [
          { name: 'Lombar Barra' },
          { name: 'Lombar Apoio' }
        ]
      },

      {
        group: 'Panturrilha',
        exercises: [
          { name: 'Panturrilha em Pé' },
          { name: 'Panturrilha Leg Press' },
          { name: 'Panturrilha Sentado' }
        ]
      },

      {
        group: 'Puxar',
        exercises: [
          { name: 'Polia Alta Neutra' },
          { name: 'Polia Alta Pronada' },
          { name: 'Polia Alta Supinada' },
          { name: 'Remada Baixa Neutra' },
          { name: 'Remada Cavalinho' },
          { name: 'Remada Curvada' },
          { name: 'Remada Unilateral' },
          { name: 'Remada Híbrida' },
          { name: 'Grande Dorsal' },
          { name: 'Barras Híbridas' },
          { name: 'Barra Reta' },
          { name: 'Barra Aberta' },
          { name: 'Barra Unilateral' }
        ]
      },

      {
        group: 'Bíceps',
        exercises: [
          { name: 'Rosca Concentrada' },
          { name: 'Rosca Scott' },
          { name: 'Rosca Unilateral' }
        ]
      },

      {
        group: 'Antebraço',
        exercises: [
          { name: 'Rosca Inversa' },
          { name: 'Apertador de Punho' },
          { name: 'Rotador de Punho' },
          { name: 'Potência 5' },
          { name: 'Super Antebraço' }
        ]
      },

      {
        group: 'Empurrar',
        exercises: [
          { name: 'Supino Reto' },
          { name: 'Supino Declinado' },
          { name: 'Supino Inclinado' },
          { name: 'Supino Halter' },
          { name: 'Supino Halter Declinado' },
          { name: 'Supino Halter Inclinado' },
          { name: 'Flexão Aberta' },
          { name: 'Flexão Triângulo' },
          { name: 'Flexão Triplo Apoio' }
        ]
      },

      {
        group: 'Tríceps',
        exercises: [
          { name: 'Tríceps Corda' },
          { name: 'Tríceps Polia' },
          { name: 'Tríceps Testa' }
        ]
      },

      {
        group: 'Aeróbico',
        exercises: [
          { name: 'Esteira', progression_type: 'treadmill' }
        ]
      }
    ].each do |info|
      info[:exercises].each do |exercise_attrs|
        group = user.groups.where(name: info[:group]).first_or_create
        exercise_attrs = { progression_type: 'repetitions' }.merge(exercise_attrs)

        slug = exercise_attrs[:name].parameterize
        exercise = user.exercises.find_or_initialize_by(slug: slug)
        exercise.assign_attributes exercise_attrs.merge(group: group)
        exercise.save
      end
    end
  end
end
