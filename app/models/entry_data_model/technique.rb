module EntryDataModel
  class Technique < Base
    DEFAULT_DIMENSIONS = [
      { name: :execution, options: {} },
      { name: :mult, options: {} },
      { name: :time, options: {} },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ].freeze
  end
end
