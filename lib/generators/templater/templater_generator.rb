require 'fileutils'
require_relative '../core'

class TemplaterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  include GeneratorsCore

  def reverse_coffeescripts
    mixins_list.each do |mixin_name|
      file_name = "app/javascript/mixins/#{plural_underscore_name}/#{mixin_name}.coffee"
      template_file_name = "#{templates_path}/mixins/#{mixin_name}.coffee"

      generate_template_from_rendered file_name, template_file_name
    end

    # guarded_template 'coffeescripts/mixins/manager.coffee', "app/javascript/mixins/#{plural_underscore_name}/manager.coffee"

    # view_models_list.each do |view_model_name|
    # end
  end

  def reverse_view_models
    view_models_list.each do |view_model_name|
      file_name = view_model_file_name(view_model_name)
      template_file_name = "#{templates_path}/view_models/#{view_model_name}.vue"
      generate_template_from_rendered file_name, template_file_name
    end
  end

  private

  def detect_dynamic_spacing(last_line, this_line)
    # Wont do
    # last_line = last_line.split('(').first
    # if last_line.index('_dash_') || last_line.index('_dash_')

    # end
    this_line
  end

  def generate_template_from_rendered(file_name, template_file_name)
    puts "file_name: #{file_name}, template_file_name: #{template_file_name}"

    return unless File.exist?(file_name)

    lines = File.readlines file_name
    last_line = nil

    contents = lines.map do |line|
      %w[plural_entity_name entity_name plural_underscore_name underscore_name].each do |placeholder|
        value = send(placeholder)
        initial_index = line.index value

        next unless initial_index

        last_index = initial_index + value.length
        last_char = line[last_index]

        # Smart backward replaces
        if placeholder == 'entity_name'
          if last_char == '\''
            placeholder = 'human_name'
          end
        elsif placeholder.end_with? 'underscore_name'
          if last_char == '-'
            placeholder.gsub! 'underscore', 'dash'
          elsif /[[:upper:]]/.match last_char
            placeholder = placeholder.gsub('underscore_name', '') + 'lowercase_entity_name'
          end
        end

        line.gsub! value, "<%= #{placeholder} %>"
        detect_dynamic_spacing last_line, line
      end

      last_line = line
    end.map(&:rstrip).join "\n"

    ensure_directory template_file_name

    File.open(template_file_name, 'w') do |f|
      f.write(contents)
    end
  end
end
