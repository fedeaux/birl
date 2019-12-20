module EntryDataModel
  class WeightlessHiit < Base
    DEFAULT_DIMENSIONS = [
      { name: :mult, options: {} },
      { name: :time, options: {} },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ]
  end
end
