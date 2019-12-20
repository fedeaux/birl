module EntryDataModel
  class MetronomeGroup < Base
    DEFAULT_DIMENSIONS = [
      { name: :mult, options: {} },
      { name: :bpmm, options: { uneditable: true } },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ]

    GLOBAL_DIMENSIONS = [
      { name: :bpm, options: {}}
    ]
  end
end
