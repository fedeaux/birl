class GoalTracker
  def goals
    {
      march_2020: {
        list: [
          # Sleep
          {
            tag_fullname: 'life:sleep',
            metrics: {
              list: [
                { type: :mean_duration, between: [8, 9.5] },
                { type: :mean_finish, less_than: 9.51 },
              ]
            }
          },

          # Runa
          {
            tag_fullname: 'work:runa',
            metrics: {
              list: [
                { type: :total_duration, tag_fullname: 'work:runa:squad_ron', more_than: 105 },
                { type: :total_duration, tag_fullname: 'work:runa:qa_automation', more_than: 25 },
                { type: :total_duration, tag_fullname: 'work:runa:frontend_architecture', more_than: 25 }
              ]
            }
          },

          # Training
          {
            tag_fullname: 'progressions:home_training',
            metrics: {
              list: [
                { type: :entries_count, more_than: 12, context_name: 'Bodybuilding' }
              ]
            }
          },

          # Music
          {
            tag_fullname: 'progressions:guitar',
            metrics: {
              list: [
                { type: :entries_count, more_than: 12, progression_name: 'Guitar Basics' }
              ]
            }
          }
        ]
      }
    }
  end
end
