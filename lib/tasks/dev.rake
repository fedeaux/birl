namespace :dev do
  desc 'TODO'
  task rename_icons: :environment do
    Dir['app/assets/images/icons/*.png'].each do |icon_name|
      path = icon_name.split('/')[0..-2].join('/')
      dim = icon_name.split('_x_').last
      name = [path, dim].join '/'
      `mv #{icon_name} #{name}`
    end
  end

  task test_data_models: :environment do
    ap EntryDataModel::MaxRepetitions.new(reps: [2, 4, 7, 10, 12], rest: [90, 75, 60, 60]).entry_data_model
  end

  task update_entries_data_model: :environment do
    Entry.all.each do |entry|
      next unless entry.value.is_a?(Hash) && entry.value['sets'] && entry.value['sets'].is_a?(Array)

      entry.value['sets'].each do |set|
        if set['seconds']
          ap entry
          break
        end
      end

      entry.save
    end
  end

  task audio_config: :environment do
    config_file_name = "audio_config.yaml"
    config = File.exist?(config_file_name) ? YAML.load_file(config_file_name).deep_symbolize_keys : { schemas: {} }
    events = [:rest_finished, :doit_finished]

    Dir['app/assets/audios/schemas/*'].each do |schema|
      schema_name = schema.split('/').last.to_sym
      config[:schemas][schema_name] ||= { events: nil, image: nil }
      config[:schemas][schema_name][:events] ||= events.map { |e| [e, []] }.to_h
      current = config[:schemas][schema_name][:events].values.flatten.uniq
      new_files = []

      Dir["#{schema}/*.mp3"].each do |file_path|
        file_name = file_path.split('/').last
        next unless file_name =~ /\d+\./
        next if current.include? file_name

        new_files.push file_name
      end

      all = (current + new_files).uniq.sort

      events.each do |event|
        next if config[:schemas][schema_name][:events][event].any?

        config[:schemas][schema_name][:events][event] = all.clone
      end

      config[:schemas][schema_name][:new_files] = new_files.clone if new_files.any?
    end

    File.open(config_file_name, 'w') do |f|
      f.write config.to_yaml
    end
  end
end

# Rename 'sets' to 'mult'
# entry.value['sets'].each do |set|
#   if set['sets']
#     set['mult'] = set['sets']
#     set.delete('sets')
#   end
# end
