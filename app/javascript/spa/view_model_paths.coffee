# TODO: Auto generate paths

entities = ['groups', 'exercises', 'challenges', 'progressions', 'entries', 'trainings', 'contexts', 'sessions', 'session_progressions', 'listers', 'vocabularies', 'tags', 'memes']
views = ['show', 'index', 'display', 'list', 'list/item', 'form', 'new', 'edit', 'select', 'manager']

paths = [
  'home'

  'desktop/index'
  'desktop/home'
  'mobile/index'
  'mobile/home'

  'entity/list/empty'
  'entity/list/item/divider'
  'shared/footer'
  'shared/link'
  'shared/modal'
  'shared/view'

  'inputs/clearable'
  'inputs/time'

  'challenges/data_models/picker'
  'challenges/data_models/picker_item'
  'contexts/choose'
  'contexts/things'
  'entries/generator'
  'entries/value/display'
  'entries/value/picker'
  'entries/value/set_picker'
  'entries/value/sets_picker'
  'listers/value/picker'
  'memes/stream/index'
  'memes/stream/list'
  'memes/stream/item'
  'progressions/execute'
  'progressions/in_session'
  'tags/hierarchy'
  'tags/hierarchy/item'
  'tags/tag'
  'tags/tag_list'
  'tags/tags'
  'tag_taggables/picker'

  'timelogs/range'
  'timelogs/timer'
  'timelogs/today'

  'timeline/day'
  'timeline/item'
  'timeline/rule'
  'timeline/step'

  'executor/audio_controls'
  'executor/counter'
  'executor/display'
  'executor/index'
  'executor/metronome'
  'executor/progress_bar'
  'questioner/item'
]

meme_types = [
  'morning_checkup'
]

for entity in entities
  for view in views
    paths.push "#{entity}/#{view}"

for meme_type in meme_types
  paths.push "memes/types/#{meme_type}/form"
  paths.push "memes/types/#{meme_type}/button"

export default { paths }
