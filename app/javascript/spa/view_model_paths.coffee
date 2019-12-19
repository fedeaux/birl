# TODO: Auto generate paths

entities = ['groups', 'exercises', 'challenges', 'progressions', 'entries', 'trainings', 'contexts', 'sessions']
views = ['show', 'index', 'display', 'list', 'list/item', 'form', 'new', 'edit', 'select', 'manager']

paths = [
  'shared/footer'
  'entity/list/empty'
  'entity/list/item/divider'
  'progressions/in_session'
  'progressions/execute'
  'entries/generator'
  'entries/value/picker'
  'entries/value/display'
  'entries/value/sets_picker'
  'entries/value/set_picker'
  'contexts/choose'
  'executor/index'
  'executor/counter'
  'executor/progress_bar'
  'executor/display'
]

for entity in entities
  for view in views
    paths.push "#{entity}/#{view}"

export default { paths }
