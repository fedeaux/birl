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
end
