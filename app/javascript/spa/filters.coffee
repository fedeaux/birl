export default {
  seconds: (seconds) ->
    seconds = parseInt seconds

    signal = seconds < 0 and '-' or ''
    seconds = Math.abs seconds

    hours = parseInt seconds / 3600
    seconds -= hours * 3600
    minutes = parseInt seconds / 60
    seconds -= minutes * 60

    parts = [signal]

    if hours > 0
      parts.push "#{hours}h"

    if minutes > 0
      parts.push "#{minutes}m"

    if seconds != 0
      parts.push "#{seconds}s"

    return '--:--' unless parts.length > 0

    parts.join('')
}
