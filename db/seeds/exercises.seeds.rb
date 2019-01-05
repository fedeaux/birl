# coding: utf-8
after(:users) do
  User.find_each do |user|
    [{
       tags: ['abdominal'],
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
         { name: 'Abdominal Canivete' },
       ]
     },

     {
       tags: ['perna', 'multiarticular'],
       exercises: [
         { name: 'Agachamento' },
         { name: 'Stiff' },
         { name: 'Avanço Halter' },
         { name: 'Legpress' },
       ]
     },

     {
       tags: ['perna', 'isolado'],
       exercises: [
         { name: 'Cadeira Abdutora' },
         { name: 'Cadeira Adutora' },
         { name: 'Cadeira Extensora' },
         { name: 'Cadeira Flexora' }
       ]
     },

     {
       tags: ['empurrar', 'peito', 'isolado'],
       exercises: [
         { name: 'Cross Over Supra' },
         { name: 'Cross Over Meio' },
         { name: 'Cross Over Infra' },
         { name: 'Peck Deck' },
         { name: 'Pull Over' },
       ]
     },

     {
       tags: ['empurrar', 'ombro', 'isolado'],
       exercises: [
         { name: 'Arnold Press' },
         { name: 'Desenvolvimento Halter' },
         { name: 'Elevação Frontal' },
         { name: 'Elevação Lateral Polia' },
         { name: 'Elevação Lateral' },
         { name: 'Remada Alta' },
         { name: 'Segundo Tempo' },
       ]
     },

     {
       tags: ['puxar', 'trapézio', 'isolado'],
       exercises: [
         { name: 'Trapézio Halter' },
       ]
     },

     {
       tags: ['lombar'],
       exercises: [
         { name: 'Lombar Barra' },
         { name: 'Lombar Apoio' },
       ]
     },

     {
       tags: ['panturrilha'],
       exercises: [
         { name: 'Panturrilha em Pé' },
         { name: 'Panturrilha Leg Press' },
       ]
     },

     {
       tags: ['puxar', 'multiarticular'],
       exercises: [
         { name: 'Polia Alta Neutra' },
         { name: 'Polia Alta Pronada' },
         { name: 'Polia Alta Supinada' },
         { name: 'Remada Baixa Neutra' },
         { name: 'Remada Cavalinho' },
         { name: 'Remada Curvada' },
         { name: 'Remada Unilateral' },
         { name: 'Remada Híbrida' },
         { name: 'Trapézio Descendente' },
         { name: 'Trapézio Escapular' },
         { name: 'Grande Dorsal' },
         { name: 'Barras Híbridas' },
         { name: 'Barra Reta' },
         { name: 'Barra Aberta' },
         { name: 'Barra Unilateral' },
       ]
     },

     {
       tags: ['puxar', 'bíceps', 'multiarticular'],
       exercises: [
         { name: 'Rosca Concentrada' },
         { name: 'Rosca Scott' },
         { name: 'Rosca Unilateral' },
       ]
     },

     {
       tags: ['puxar', 'antebraço', 'multiarticular'],
       exercises: [
         { name: 'Rosca Inversa' },
       ]
     },

     {
       tags: ['empurrar', 'multiarticular'],
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
       tags: ['empurrar', 'tríceps', 'isolado'],
       exercises: [
         { name: 'Tríceps Corda' },
         { name: 'Tríceps Polia' },
         { name: 'Tríceps Testa' }
       ]
     },

     {
       tags: ['esteira'],
       exercises: [
         { name: 'Esteira' }
       ]
     },

     {
       tags: ['antebraço'],
       exercises: [
         { name: 'Apertador de Punho' },
         { name: 'Rotador de Punho' },
         { name: 'Potência 5' },
         { name: 'Super Antebraço' },
       ]
     }
    ].each do |info|
      info[:exercises].each do |exercise_attrs|
        slug = exercise_attrs[:name].parameterize
        exercise = user.exercises.find_or_initialize_by(slug: slug)
        next if exercise.persisted?
        exercise.assign_attributes exercise_attrs
        exercise.save
      end
    end
  end
end
