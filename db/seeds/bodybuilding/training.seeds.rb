require_relative '../support/training_seeder'

after(:challenges) do
  TrainingSeeder.new.seed
end
