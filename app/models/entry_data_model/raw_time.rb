module EntryDataModel
  class RawTime < Base
    DEFAULT_DIMENSIONS = [
      { name: :mult, options: {} },
      { name: :time, options: {} },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ].freeze
  end
end
