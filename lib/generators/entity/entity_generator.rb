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
    '      ' + attributes.map(&:column_name).join(": {}\n      ")+": {}"
  end

  def guarded_template(source, target)
    return if (File.exists?(target) and File.readlines(target).last.strip == '# NO-OVERRIDE') or !template_exists?(source)
    template source, target
  end
end
