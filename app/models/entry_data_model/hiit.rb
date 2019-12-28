module EntryDataModel
  class Hiit < Base
    DEFAULT_DIMENSIONS = [
      { name: :mult, options: {} },
      { name: :time, options: {} },
      { name: :load, options: {} },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ].freeze
  end
end
