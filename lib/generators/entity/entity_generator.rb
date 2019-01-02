class EntityGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  include Rails::Generators::ModelHelpers
  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  # def generate_model
  #   generate 'model', ARGV.join(" ")
  # end

  def generate_controller
    template "controller.rb", controller_file_name
  end

  private

  def underscore_name
    singular_name.underscore
  end

  def entity_name
    singular_name.camelcase
  end

  def plural_underscore_name
    name.underscore.pluralize
  end

  def plural_entity_name
    name.camelcase.pluralize
  end

  def controller_file_name
    "app/controllers/api/v1/#{name.pluralize.downcase}_controller.rb"
  end

  def controller_name
    "#{plural_entity_name}Controller"
  end

  def attributes_as_symbol_list
    ':' + attributes.map(&:name).join(', :')
  end
end
