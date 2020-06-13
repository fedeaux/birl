class Lister
  constructor: ->
    @lists = {
      # Music
      musical_notes: ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#']
      musical_small_intervals: ['2m', '2M', '3m', '3M', '4J', '4#']

      # Guitar
      cromatisms_warmup: ['1234', '2341', '3412', '4123']
      cromatisms_hard: ['1342', '2431', '3124', '4213']
      cromatisms_regular: ['1243', '2134', '1324', '2413', '1423', '2314']
      easy_cromatisms_variations: ['stairs', 'pestana', 'one string', 'string jump']
      hard_cromatisms_variations: ['x']

      guitar_expressions: ['hammers&pulls', 'vibrato', 'bends', 'trills', 'octave playng',
                           'double bends', 'left tapping', 'slide', 'volume swell']

      arpeggios: ['m7 (5)', 'M7 (5)', 'M7+ (6)']

      # Karate
      kyokushin_kicks_basics: ['Mae Geri']
      kyokushin_kicks_basics_one_leg: ['Mawashi Geri']

      kyokushin_kicks_secondary: ['Yoko Geri', 'Ushiro Geri', 'Uchi Heisoku Geri Jodan', 'Ura Mawashi Geri', 'Kubi Geri']

      kyokushin_kicks_stretch: ['Uchi Mawashi Geri', 'Yoko Keage Geri']
      kyokushin_kicks_stretch_one_leg: ['Mae Keage Geri']

      kyokushin_kicks_hard: ['Ushiro Mawashi Geri', 'Uchi Kakato Oroshi Geri', 'Soto Kakato Ohoshi Geri']
      kyokushin_kicks_explosive: ['Explosive Mawashi Geri', 'Explosive Gedan Mawashi Geri']

      # Yoga
      yoga_sessions: [
        { link: 'https://www.youtube.com/watch?v=sO3g2fm0Gcw' }
        { link: 'https://www.youtube.com/watch?v=sXSzAeOADbE' }
        { link: 'https://www.youtube.com/watch?v=SYJtLGrod7Y' }
      ]
    }

    for list in window.Global.server.lists
      @lists[list.name] = list.values.items

  item: (list) ->
    n = @lists[list].length
    @lists[list][@r(n)]

  r: (n, offset = 0) ->
    offset + Math.floor Math.random() * n

  both_sides: (args) ->
    result = []
    for kick in @list args[0], args[1]
      result.push "Right #{kick}"
      result.push "Left #{kick}"

    result

  musical_notes_with_height: (count) ->
    "#{note}#{@r(3, 2)}" for note in @list('musical_notes', count)

  all: (list) ->
    JSON.parse JSON.stringify @lists[list]

  shuffled: (list) ->
    all = @all list
    return all unless all.length >= 2

    for index in [all.length - 1..1]
      new_index = Math.floor Math.random() * (index + 1)
      while new_index == index
        new_index = Math.floor Math.random() * (index + 1)

      [all[index], all[new_index]] = [all[new_index], all[index]]

    all

  list: (list, count) ->
    return @[list](count) unless _.isArray @lists[list]
    return @all(list) unless count

    all = @shuffled list
    result = []

    for index in [0..count - 1]
      result.push all[index % all.length]

    result

window.Lister = Lister
export default Lister
