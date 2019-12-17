module EntryDataModel
  class TreadmillHiit < Base
    DEFAULT_DIMENSIONS = [
      { name: :sets, options: {} },
      { name: :speed, options: {} },
      { name: :time, options: {} },
      { name: :rest, options: {} }
    ]
  end
end
