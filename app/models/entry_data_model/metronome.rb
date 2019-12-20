module EntryDataModel
  class Metronome < Base
    DEFAULT_DIMENSIONS = [
      { name: :mult, options: {} },
      { name: :bpm, options: {} },
      { name: :pause, options: {} },
      { name: :rest, options: {} }
    ]
  end
end
