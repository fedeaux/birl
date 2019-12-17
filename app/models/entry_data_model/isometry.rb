module EntryDataModel
  class Isometry < Base
    DEFAULT_DIMENSIONS = [
      { name: :sets, options: {} },
      { name: :time, options: {} },
      { name: :weight, options: {} },
      { name: :rest, options: {} }
    ]
  end
end
