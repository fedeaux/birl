# TODO: Auto generate paths

entities = ['groups', 'exercises', 'challenges', 'progressions', 'entries', 'trainings', 'contexts', 'sessions', 'session_progressions', 'listers']
views = ['show', 'index', 'display', 'list', 'list/item', 'form', 'new', 'edit', 'select', 'manager']

paths = [
  'challenges/data_models/picker'
  'challenges/data_models/picker_item'
  'contexts/choose'
  'entity/list/empty'
  'entity/list/item/divider'
  'entries/generator'
  'entries/value/display'
  'entries/value/picker'
  'entries/value/set_picker'
  'entries/value/sets_picker'
  'executor/audio_controls'
  'executor/counter'
  'executor/display'
  'executor/index'
  'executor/metronome'
  'executor/progress_bar'
  'listers/value/picker'
  'progressions/execute'
  'progressions/in_session'
  'shared/footer'
]

for entity in entities
  for view in views
    paths.push "#{entity}/#{view}"

export default { paths }
