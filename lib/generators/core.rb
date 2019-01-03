module GeneratorsCore
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
    %w[show index list list/item picker new edit form]
  end
end
