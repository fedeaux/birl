export default class AsciiDrawer
  constructor: (@args) ->
    @default_char = '-'

  rowToChar: (row) ->
    @chars row.length

  rowsDiffToChar: (row_a, row_b) ->
    @chars row_a.length - row_b.length

  largestLength: (rows) ->
    Math.max (row.length for row in rows)...

  chars: (n = 1, char = @default_char) ->
    Array(n + 1).join char

  fillToMatchLargest: (rows) ->
    n = @largestLength rows

    for index of rows
      if rows[index].length < n
        rows[index] += @chars(n - rows[index].length)

    rows

  stripWhitespace: (rows) ->
    for index of rows
      rows[index] = rows[index].replace /\s+/g, ''

    rows

  draw: ->
    return JSON.stringify @args unless @args.ascii_drawing.model == 'fretboard' and @args.ascii_drawing.preset == 'x'

    [a, b, c, d] = @args.text.split('')
    [a, b, c, d] = '1324'.split('')

    rows = []

    rows[0] = "#{a}-#{b}-#{c}-#{d}-"
    rows[1] = @rowToChar(rows[0]) + "#{c}-"
    rows[2] = @rowToChar(rows[1]) + "#{b}-"
    rows[3] = @rowToChar(rows[2]) + "#{a}-#{b}-#{c}-#{d}-"

    @fillToMatchLargest @stripWhitespace rows

    rows[2] += "-#{c}-"
    rows[1] += @rowsDiffToChar(rows[2], rows[1]) + "-#{b}-"
    rows[0] += @rowsDiffToChar(rows[1], rows[0]) + "-#{a}-#{b}-#{c}-#{d}-"

    @fillToMatchLargest @stripWhitespace rows

    rows.join "\n"
