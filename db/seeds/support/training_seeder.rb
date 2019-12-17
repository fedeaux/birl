class TrainingSeeder
  attr_accessor :training

  def seed
    @created_session_ids = []

    training_spreadsheet.worksheets.each do |worksheet|
      seed_training_from_worksheet worksheet
    end

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
    order = 0

    worksheet.rows.transpose.each do |row|
      row.each do |col|
        if col.present?
          if session
            progression = ensure_progression col
            SessionProgression.where(progression_id: progression.id, session_id: session.id, order: order).first_or_create
            order += 1
          else
            session = create_session col
            order = 0
          end
        else
          session = nil
        end
      end
    end
  end

  def create_session(signature)
    parts = signature.split('-').map(&:strip)
    name = parts[0]
    weekday = Date.strptime(parts[1], '%A').wday

    session = Session.where(training_id: training.id, name: name).first_or_create
    session.update(weekday: weekday)
    @created_session_ids.push session.id
    session
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
