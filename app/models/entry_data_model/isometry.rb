module EntryDataModel
  class Isometry < Base
    DEFAULT_DIMENSIONS = [
      { name: :mult, options: {} },
      { name: :time, options: {} },
      { name: :weight, options: {} },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ]
  end
end
