require_relative '../core'

class EntityGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  include GeneratorsCore
  include Rails::Generators::ModelHelpers

  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  def generate_model
    generate 'model', ARGV.join(" ")
  end

  def generate_controller
    guarded_template "controller.rb", controller_file_name
  end

  def add_route
    inject_into_file 'config/routes.rb', "      resources :#{plural_underscore_name}\n", after: "    namespace :v1 do\n"
  end

  def generate_responses
    guarded_template "views/_show.json.jbuilder", response_file_name('_show')
    guarded_template "views/show.json.jbuilder", response_file_name('show')
    guarded_template "views/index.json.jbuilder", response_file_name('index')
  end

  def generate_coffeescripts
    guarded_template "coffeescripts/model.coffee", "app/javascript/models/#{underscore_name}.coffee"
    guarded_template "coffeescripts/resource.coffee", "app/javascript/resources/#{plural_underscore_name}_resource.coffee"
  end

  def generate_view_models
    view_models_list.each do |view_model_name|
      guarded_template "view_models/#{view_model_name}.vue", view_model_file_name(view_model_name)
    end
  end

  private

  def attributes_as_symbol_list
    ':' + attributes.map(&:column_name).join(', :')
  end

  def attributes_as_front_model_list
    attr_strings = []

    attributes.each do |attribute|
      attr_strings.concat attribute_as_front_model_list_item(attribute)
    end

    '      ' + attr_strings.join("\n      ")
  end

  def guarded_template(source, target)
    return if (File.exists?(target) and File.readlines(target).last.strip == '# NO-OVERRIDE') or !template_exists?(source)
    template source, target
  end

  def attribute_as_front_model_list_item(attribute)
    if attribute.reference?
      [
        "#{attribute.name}: #{attribute_front_model_list_item_type(attribute)}",
        "#{attribute.column_name}: {}"
      ]
    else
      ["#{attribute.name}: #{attribute_front_model_list_item_type(attribute)}"]
    end
  end

  def attribute_front_model_list_item_type(attribute)
    return "{ type: #{attribute.name.camelize} }" if attribute.reference?
    '{}'
  end

  def reference_attributes_as_front_model_imports
    attributes.select(&:reference?).map do |attribute|
      "import #{attribute.name.camelize} from './#{attribute.name}'"
    end.join "\n"
  end

  def method_missing(name, *args, &block)
    name = name.to_s
    super(name, args, block) unless name.end_with? '_as_spaces'
    ' ' * send(name.gsub('_as_spaces', '')).length
  end
end
