class TrainingSeeder
  attr_accessor :training

  def seed
    @created_session_ids = []

    training_spreadsheet.worksheets.each do |worksheet|
      seed_training_from_worksheet worksheet
    end

    special_progressions
    cleanup_stale
    check
  end

  private

  def cleanup_stale
    Session.where('id NOT IN (?)', @created_session_ids).destroy_all
  end

  def check
    Training.all.each do |training|
      puts '------------------------------------------'
      puts "Training #{training.id}: #{training.name}"
      training.sessions.each do |session|
        puts ''
        puts " -- #{session.name} on #{session.weekday} -- "
        tp session.progressions, :id, :'exercise.name', :'challenge.name'
      end
    end
  end

  def seed_training_from_worksheet(worksheet)
    self.training = Training.where(name: worksheet.title, context_id: context.id).first_or_create
    training.sessions.destroy_all

    session = nil

    worksheet.rows.transpose.each do |row|
      row.each do |col|
        if col.present?
          if session
            progression = ensure_progression col
            ensure_session_progression progression, session, @order
            @order += 1
          else
            session = ensure_session col
          end
        else
          session = nil
        end
      end
    end
  end

  def ensure_session(signature)
    parts = signature.split('-').map(&:strip)
    name = parts[0]
    weekday = Date.strptime(parts[1], '%A').wday

    session = Session.where(training_id: training.id, name: name).first_or_create
    session.update(weekday: weekday)
    @created_session_ids.push session.id
    @order = ensure_everyday_progressions session
    session
  end

  def ensure_everyday_progressions(session)
    # smells like teen coding
    return 0

    # ['Respiração Rápida - HIIT sem peso',
    #  'Espiração com Pressão - HIIT sem peso',
    #  'Bananeira - Movimento'].each_with_index do |signature, index|
    #   progression = ensure_progression signature
    #   ensure_session_progression progression, session, index
    # end.count
  end

  def ensure_session_progression(progression, session, order)
    sp = SessionProgression.where(progression_id: progression.id, session_id: session.id).first_or_create
    sp.update(order: order)
  end

  def ensure_progression(signature)
    parts = signature.split('-').map(&:strip)
    exercise = Exercise.where(name: parts[0], context_id: context.id).first_or_create
    challenge = Challenge.where(name: parts[1], context_id: context.id).first_or_create
    progression = Progression.where(challenge_id: challenge.id, exercise_id: exercise.id, context_id: context.id).first_or_create

    puts "-> Failed to create exercise #{parts[0]}: #{exercise.errors.messages}" unless exercise.persisted?
    puts "-> Failed to create challenge #{parts[1]}: #{challenge.errors.messages}" unless challenge.persisted?
    puts "-> Failed to create progression #{parts[0]}: #{progression.errors.messages}" unless progression.persisted?

    progression
  end

  def special_progressions
    chutes_kyokushin = Progression.find_by(name: 'Chutes Kyokushin - HIIT (leve)')
    return unless chutes_kyokushin

    chutes_kyokushin.update(override_entry_data_model: {
                              generator: {
                                name: :kyokushin_kihon_kicks
                              }
                            })
  end

  def user
    @user ||= User.find_by(email: 'phec06@gmail.com')
  end

  def context
    @context ||= user.context 'bodybuilding'
  end

  def training_spreadsheet
    @training_spreadsheet ||= gdocs_session.spreadsheet_by_key('1ViUobZTDswokXTkMBdmEdHmJsPnM9vXd4QAJHIPuHgI')
  end

  def gdocs_session
    @gdocs_session ||= GoogleDrive::Session.from_config('google_config.json')
  end
end
