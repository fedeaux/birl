require_relative './support/vocabulary_seeder.rb'

after(:contexts) do
  # Very Dangerous Seed!!!!!!!!

  # Vocabulary.destroy_all

  # Dir['db/seeds/vocabularies/*'].each do |file|
  #   kind = file.split('/').last
  #   contents = File.read file

  #   VocabularySeeder.new(kind, contents).seed
  # end
end
