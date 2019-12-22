module GeneratorsCore
  # some_entity
  def underscore_name
    singular_name.underscore
  end

  # some-entity
  def dash_name
    underscore_name.gsub '_', '-'
  end

  # SomeEntity
  def entity_name
    singular_name.camelcase
  end

  # someEntity
  def lowercase_entity_name
    singular_name.camelize(:lower)
  end

  # Some Entity
  def human_name
    underscore_name.gsub('_', ' ').titleize
  end

  # some_entities
  def plural_underscore_name
    name.underscore.pluralize
  end

  # some-entities
  def plural_dash_name
    plural_underscore_name.gsub '_', '-'
  end

  # SomeEntities
  def plural_entity_name
    name.camelcase.pluralize
  end

  # someEntities
  def plural_lowercase_entity_name
    name.camelcase(:lower).pluralize
  end

  # Some Entity
  def plural_human_name
    plural_underscore_name.gsub('_', ' ').titleize
  end

  def controller_file_name
    "app/controllers/api/v1/#{name.pluralize.downcase}_controller.rb"
  end

  def response_file_name(file_name)
    "app/views/api/v1/#{plural_underscore_name}/#{file_name}.json.jbuilder"
  end

  def view_model_file_name(view_model_name)
    "app/javascript/view_models/#{plural_underscore_name}/#{view_model_name}.vue"
  end

  def controller_name
    "#{plural_entity_name}Controller"
  end

  def view_models_list
    %w[show index list list/item new edit form select manager display]
    %w[manager]
  end

  def ensure_directory(file)
    dirname = File.dirname(file)
    FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
  end

  def templates_path
    'lib/generators/entity/templates'
  end

  def template_exists?(name)
    File.exist? "#{templates_path}/#{name}"
  end
end
