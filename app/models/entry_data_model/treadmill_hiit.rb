module EntryDataModel
  class TreadmillHiit < Base
    DEFAULT_DIMENSIONS = [
      { name: :mult, options: {} },
      { name: :speed, options: {} },
      { name: :time, options: {} },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ].freeze
  end
end
