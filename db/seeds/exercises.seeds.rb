# coding: utf-8
after(:users) do
  user = User.first

  [{
    tags: ['abdominal'],
    exercises: [
      { id: 1, name: 'Abdominal Dragão' },
      { id: 2, name: 'Abdominal Polia' },
      { id: 3, name: 'Abdominal Prancha' },
      { id: 4, name: 'Abdominal Rodinha' },
      { id: 5, name: 'Abdominal Vela' },
      { id: 55, name: 'Abdominal Barra' },
      { id: 56, name: 'Abdominal Barra Lateral' },
      { id: 57, name: 'Abdominal Dragão Lateral' },
      { id: 58, name: 'Obliquo Polia' },
      { id: 59, name: 'Abdominal Canivete' },
    ]
   },

    {
      tags: ['perna', 'multiarticular'],
      exercises: [
        { id: 6, name: 'Agachamento' },
        { id: 7, name: 'Stiff' },
        { id: 8, name: 'Avanço Halter' },
        { id: 59, name: 'Legpress' },
      ]
    },

    {
      tags: ['perna', 'isolado'],
      exercises: [
        { id: 9, name: 'Cadeira Abdutora' },
        { id: 10, name: 'Cadeira Adutora' },
        { id: 11, name: 'Cadeira Extensora' },
        { id: 12, name: 'Cadeira Flexora' }
      ]
    },

    {
      tags: ['empurrar', 'peito', 'isolado'],
      exercises: [
        { id: 13, name: 'Cross Over Supra' },
        { id: 14, name: 'Cross Over Meio' },
        { id: 15, name: 'Cross Over Infra' },
        { id: 16, name: 'Peck Deck' },
        { id: 17, name: 'Pull Over' },
      ]
    },

    {
      tags: ['empurrar', 'ombro', 'isolado'],
      exercises: [
        { id: 18, name: 'Arnold Press' },
        { id: 19, name: 'Desenvolvimento Halter' },
        { id: 20, name: 'Elevação Frontal' },
        { id: 21, name: 'Elevação Lateral Polia' },
        { id: 22, name: 'Elevação Lateral' },
        { id: 23, name: 'Remada Alta' },
        { id: 24, name: 'Segundo Tempo' },
      ]
    },

    {
      tags: ['puxar', 'trapézio', 'isolado'],
      exercises: [
        { id: 25, name: 'Trapézio Halter' },
      ]
    },

    {
      tags: ['lombar'],
      exercises: [
        { id: 26, name: 'Lombar Barra' },
        { id: 27, name: 'Lombar Apoio' },
      ]
    },

    {
      tags: ['panturrilha'],
      exercises: [
        { id: 28, name: 'Panturrilha em Pé' },
        { id: 29, name: 'Panturrilha Leg Press' },
      ]
    },

    {
      tags: ['puxar', 'multiarticular'],
      exercises: [
        { id: 30, name: 'Polia Alta Neutra' },
        { id: 31, name: 'Polia Alta Pronada' },
        { id: 32, name: 'Polia Alta Híbrida' },
        { id: 33, name: 'Remada Baixa Neutra' },
        { id: 34, name: 'Remada Cavalinho' },
        { id: 35, name: 'Remada Curvada' },
        { id: 36, name: 'Remada Unilateral' },
        { id: 37, name: 'Remada Híbrida' },
        { id: 60, name: 'Trapézio Descendente' },
        { id: 61, name: 'Trapézio Escapular' },
        { id: 62, name: 'Grande Dorsal' },
        { id: 63, name: 'Barras Híbridas' },
        { id: 64, name: 'Barra Reta' },
        { id: 65, name: 'Barra Aberta' },
        { id: 66, name: 'Barra Unilateral' },
      ]
    },

    {
      tags: ['puxar', 'bíceps', 'multiarticular'],
      exercises: [
        { id: 38, name: 'Rosca Concentrada' },
        { id: 39, name: 'Rosca Scott' },
        { id: 70, name: 'Rosca Unilateral' },
      ]
    },

    {
      tags: ['puxar', 'antebraço', 'multiarticular'],
      exercises: [
        { id: 40, name: 'Rosca Inversa' },
      ]
    },

    {
      tags: ['empurrar', 'multiarticular'],
      exercises: [
        { id: 42, name: 'Supino Reto' },
        { id: 43, name: 'Supino Declinado' },
        { id: 44, name: 'Supino Inclinado' },
        { id: 45, name: 'Supino Halter' },
        { id: 46, name: 'Supino Halter Declinado' },
        { id: 47, name: 'Supino Halter Inclinado' },
        { id: 73, name: 'Flexão Aberta' },
        { id: 74, name: 'Flexão Triângulo' },
        { id: 75, name: 'Flexão Triplo Apoio' }
      ]
    },

    {
      tags: ['empurrar', 'tríceps', 'isolado'],
      exercises: [
        { id: 48, name: 'Tríceps Corda' },
        { id: 49, name: 'Tríceps Polia' },
        { id: 50, name: 'Tríceps Testa' }
      ]
    },

    {
      tags: ['esteira'],
      exercises: [
        { id: 51, name: 'Esteira' }
      ]
    },

    {
      tags: ['antebraço'],
      exercises: [
        { id: 52, name: 'Apertador de Punho' },
        { id: 53, name: 'Rotador de Punho' },
        { id: 54, name: 'Potência 5' },
        { id: 55, name: 'Super Antebraço' },
      ]
    }
  ].each do |info|
    info[:exercises].each do |exercise_attrs|
      exercise = Exercise.find_or_initialize_by(id: exercise_attrs[:id])
      exercise.assign_attributes exercise_attrs.merge(user: user)
      exercise.save
    end
  end
end
