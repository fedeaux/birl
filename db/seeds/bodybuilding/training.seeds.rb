require_relative '../support/training_seeder'

after('bodybuilding:challenges') do
  TrainingSeeder.new.seed
end
