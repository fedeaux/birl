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
end

# Rename 'sets' to 'mult'
# entry.value['sets'].each do |set|
#   if set['sets']
#     set['mult'] = set['sets']
#     set.delete('sets')
#   end
# end
