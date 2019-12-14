module GeneratorsCore
  def underscore_name
    singular_name.underscore
  end

  def entity_name
    singular_name.camelcase
  end

  def lowercase_entity_name
    singular_name.camelize(:lower)
  end

  def plural_underscore_name
    name.underscore.pluralize
  end

  def plural_entity_name
    name.camelcase.pluralize
  end

  def lowercase_plural_entity_name
    name.camelcase(:lower).pluralize
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
    %w[show index list list/item picker new edit form select manager]
    %w[index new edit form]
  end

  def ensure_directory(file)
    dirname = File.dirname(file)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end

  def templates_path
    'lib/generators/entity/templates'
  end

  def template_exists?(name)
    File.exists? "#{templates_path}/#{name}"
  end
end
