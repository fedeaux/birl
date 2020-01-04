namespace :dev do
  task deployed: :environment do
    %w[db:migrate db:seed db:seed:bodybuilding dev:update_entries_data_model].each do |name|
      Rake::Task[name].reenable
      Rake::Task[name].invoke
    end
  end

  task rename_icons: :environment do
    Dir['app/assets/images/icons/*.png'].each do |icon_name|
      path = icon_name.split('/')[0..-2].join('/')
      dim = icon_name.split('_x_').last
      name = [path, dim].join '/'
      `mv #{icon_name} #{name}`
    end
  end

  task rename_files: :environment do
    Dir['app/views/api/v1/*/_show.json.jbuilder'].each do |file|
      new_file = file.gsub('show', 'fields')
      `mv #{file} #{new_file}`
    end
  end

  # rake dev:test_data_models
  task test_data_models: :environment do
    ap EntryDataModel::MaxRepetitions.new(reps: [2, 4, 7, 10, 12], rest: [90, 75, 60, 60]).entry_data_model
  end

  # rake dev:update_entries_data_model
  task update_entries_data_model: :environment do
    Entry.all.each do |entry|
      entry.value = { sets: [] } unless entry.value.is_a?(Hash) && entry.value[:sets].is_a?(Array)
      value = entry.value

      value[:sets] = value[:sets].map do |set|
        if set[:weight]
          set[:load] = set[:weight]
          set.delete(:weight)
        end

        set
      end

      entry.value = value
      entry.save
    end
  end

  # rake dev:force_regen_all
  task force_regen_all: :environment do
    threads = []

    File.readlines('.generated').each do |line|
      next unless line.start_with? 'rails g entity'

      threads << Thread.new do
        puts line
        `#{line.strip} -f`
      end
    end

    threads.each(&:join)
  end

  task audio_config: :environment do
    config_file_name = 'audio_config.yaml'
    config = File.exist?(config_file_name) ? YAML.load_file(config_file_name).deep_symbolize_keys : { schemas: {} }
    events = %i[rest_finished doit_finished]

    Dir['app/assets/audios/schemas/*'].each do |schema|
      schema_name = schema.split('/').last.to_sym
      config[:schemas][schema_name] ||= { events: nil, image: nil, eventless: [] }
      config[:schemas][schema_name][:events] ||= events.map { |e| [e, []] }.to_h
      current = (config[:schemas][schema_name][:events].values + config[:schemas][schema_name][:eventless]).flatten.uniq
      new_files = []

      Dir["#{schema}/*.mp3"].each do |file_path|
        file_name = file_path.split('/').last
        next if file_name.start_with? 'ignore.'
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

  task :deploy_cordova do
    `gphm`

    file = 'cordova/www/index.html'

    `curl http://birlapp.herokuapp.com > #{file}`

    index = File.read file

    index.gsub!('href="/packs', 'href="http://birlapp.herokuapp.com/packs')
    index.gsub!('src="/packs', 'src="http://birlapp.herokuapp.com/packs')

    # index.gsub!('href="http://birlapp.herokuapp.com/packs', 'href="/packs')
    # index.gsub!('src="http://birlapp.herokuapp.com/packs', 'src="/packs')

    File.open(file, 'w') do |f|
      f.write(index)
    end

    apk = '/Users/fedorius/Work/my/birl/web/cordova/platforms/android/app/build/outputs/apk/debug/app-debug.apk'
    `rm #{apk}`

    `cd cordova/ && cordova build android`

    session = GoogleDrive::Session.from_config('google_config.json')
    session.upload_from_file(apk, 'birl.apk', convert: false)
  end
end

# Rename 'sets' to 'mult'
# entry.value['sets'].each do |set|
#   if set['sets']
#     set['mult'] = set['sets']
#     set.delete('sets')
#   end
# end
