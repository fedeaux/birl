module EntryDataModel
  class Hiit < Base
    DEFAULT_DIMENSIONS = [
      { name: :sets, options: {} },
      { name: :weight, options: {} },
      { name: :time, options: {} },
      { name: :rest, options: {} }
    ]
  end
end
