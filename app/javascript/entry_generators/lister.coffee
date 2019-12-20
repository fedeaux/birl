class Lister
  constructor: ->
    @musical_intervals = ['2m', '2M', '3m', '3M', '4J', '4#', '5J', '6m', '6M', '7m', '7M', '8J']
    @musical_notes = ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#']
    @vocal_regions = ['edge lows', 'lows', 'transition', 'highs','edge highs']
    @cromatisms_warmup = ['1234', '2341', '3412', '4123']
    @cromatisms_hard = ['1342', '2431', '3124', '4213']
    @cromatisms_regular = ['1243', '2134', '1324', '2413', '1423', '2314']

  item: (list) ->
    n = @[list].length
    @[list][@r(n)]

  r: (n, offset = 0) ->
    offset + Math.floor Math.random() * n

  musical_notes_with_height: (count) ->
    "#{note}#{@r(3, 2)}" for note in @list('musical_notes', count)

  list: (list, count) ->
    return @[list](count) unless _.isArray @[list]

    result = []

    allow_dups = @[list].length < count

    for x in [1..count]
      loop
        item = @item list

        if allow_dups || !(item in result)
          result.push item
          break

    result

export default Lister
