module ApplicationHelper
  def audio_config_json
    return '{}' unless File.exist? "audio_config.yaml"

    config = YAML.load_file("audio_config.yaml").deep_symbolize_keys

    config[:schemas].each do |schema, schema_config|
      schema_config[:events].keys.each do |event|
        next if event == :new_files

        config[:schemas][schema][:events][event] = schema_config[:events][event].map { |audio|
          audio_path("schemas/#{schema}/#{audio}")
        }
      end

      config[:schemas][schema][:eventless] = schema_config[:eventless].map { |audio|
        audio_path("schemas/#{schema}/#{audio}")
      }

      config[:schemas][schema].delete :new_files

      if File.exist? "app/assets/images/audio/#{schema}.png"
        config[:schemas][schema][:image] = image_path("audio/#{schema}.png")
      end
    end

    config.to_json
  end

  def lists_json
    Lister.all.to_json
  end

  def entry_data_model_data_json
    {
      dimensions: []
    }.to_json
  end
end
