# TODO: Auto generate paths

entities = ['groups', 'exercises', 'challenges', 'progressions', 'entries', 'trainings', 'contexts', 'sessions', 'session_progressions', 'listers', 'vocabularies', 'tags', 'memes']
views = ['show', 'index', 'display', 'list', 'list/item', 'form', 'new', 'edit', 'select', 'manager']

paths = [
  'entity/list/empty'
  'entity/list/item/divider'
  'shared/footer'
  'shared/modal'
  'inputs/clearable'

  'challenges/data_models/picker'
  'challenges/data_models/picker_item'
  'contexts/choose'
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
  'tags/tags'
  'tag_taggables/picker'

  'executor/audio_controls'
  'executor/counter'
  'executor/display'
  'executor/index'
  'executor/metronome'
  'executor/progress_bar'
  'questioner/item'
]

for entity in entities
  for view in views
    paths.push "#{entity}/#{view}"

export default { paths }
