require_relative '../core'

class EntityGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  include GeneratorsCore
  include Rails::Generators::ModelHelpers

  argument :attributes, type: :array, default: [], banner: 'field[:type][:index] field[:type][:index]'

  def initialize(a, b, c)
    super a, b, c
    @config = YAML::load_file 'brain-damage.yml'
  end

  def generate_model
    return unless generate_model?

    generate 'model', ARGV.join(' ')
  end

  def add_route
    inject_into_file 'config/routes.rb', "      resources :#{plural_underscore_name}\n", after: "    namespace :v1 do\n"
  end

  def generate_controller
    return unless generate_controller?

    guarded_template 'controller.rb', controller_file_name
  end

  def generate_responses
    return unless generate_responses?

    guarded_template 'views/_fields.json.jbuilder', response_file_name('_fields')
    guarded_template 'views/_show.json.jbuilder', response_file_name('_show')
    guarded_template 'views/show.json.jbuilder', response_file_name('show')
    guarded_template 'views/index.json.jbuilder', response_file_name('index')
  end

  def generate_coffeescripts
    return unless generate_coffeescripts?

    guarded_template 'coffeescripts/model.coffee', "app/javascript/models/#{underscore_name}.coffee"
    guarded_template 'coffeescripts/resource.coffee', "app/javascript/resources/#{plural_underscore_name}_resource.coffee"
  end

  def generate_mixins
    return unless generate_mixins?

    mixins_list.each do |mixin_name|
      guarded_template "mixins/#{mixin_name}.coffee", "app/javascript/mixins/#{plural_underscore_name}/#{mixin_name}.coffee"
    end
  end

  def generate_view_models
    return unless generate_view_models?

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

  def sub_template_contents(name)
    contents = (@sub_templates[name] || '')
    contents.empty? ? contents : "#{contents}\n"
  end

  def sub_template(name, comment = '//-', indent = 2)
    "#{spaces(indent)}#{comment} BrainDamage: #{name} Start\n#{sub_template_contents(name)}#{spaces(indent)}#{comment} BrainDamage: #{name} End"
  end

  def guarded_template(source, target)
    @sub_templates = {}

    if File.exist?(target)
      return if (File.readlines(target).last.strip == 'BrainDamage: NO-OVERRIDE') || !template_exists?(source)

      regex = %r{(//-|#)\sBrainDamage\:\s(?<name>\w+)\sStart}
      str = File.read target

      str.scan(regex).each do |name|
        name = name.first
        regex = %r{(//-|#)\sBrainDamage\:\s#{name}\sStart\n(?<contents>.*)\s+(//-|#)\s+BrainDamage\:\s#{name}\sEnd}m

        ass = str.match(regex)
        next unless ass

        contents = ass[1]

        next if contents.strip.empty?

        @sub_templates[name] = contents.gsub(/(\A[\r\n]+)/, '').gsub(/([\r\n\s]+\z)/, '')
      end
    end

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

  def spaces(count)
    ' ' * count
  end

  def method_missing(name, *args, &block)
    name = name.to_s

    if name.end_with? '_as_spaces'
      spaces send(name.gsub('_as_spaces', '')).length
    elsif name =~ /generate_\w+\?/
      generatable = name.gsub('generate_', '').gsub('?', '')
      @config['generate'].has_key? generatable
    else
      super(name.to_sym, args, block)
    end
  end
end
