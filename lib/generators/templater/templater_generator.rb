require_relative '../core'

class TemplaterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  include GeneratorsCore

  REPLACE_TABLE = [
    ['plural_entity_name', '<%= plural_entity_name %>']
  ]

  def view_models
    view_models_list.each do |view_model_name|
      generate_template_from_rendered view_model_name
    end
  end

  private

  def generate_template_from_rendered(view_model_name)
    file_name = view_model_file_name(view_model_name)
    return unless File.exists?(file_name)
    contents = File.read file_name

    %w[plural_entity_name singular_entity_name plural_underscore_name underscore_name]
  end
end
