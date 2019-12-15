require 'fileutils'
require_relative '../core'

class TemplaterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  include GeneratorsCore

  REPLACE_TABLE = [
    ['plural_entity_name', '<%= plural_entity_name %>']
  ].freeze

  def view_models
    view_models_list.each do |view_model_name|
      generate_template_from_rendered view_model_name
    end
  end

  private

  def generate_template_from_rendered(view_model_name)
    file_name = view_model_file_name(view_model_name)
    template_file_name = "#{templates_path}/view_models/#{view_model_name}.vue"
    return unless File.exist?(file_name)

    contents = File.read file_name

    %w[plural_entity_name entity_name plural_underscore_name underscore_name].each do |placeholder|
      value = send(placeholder)
      contents.gsub!(value, "<%= #{placeholder} %>")
    end

    ensure_directory template_file_name

    File.open(template_file_name, 'w') do |f|
      f.write(contents)
    end
  end
end
