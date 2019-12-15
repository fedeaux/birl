# TODO: Auto generate paths

entities = ['groups', 'exercises', 'challenges', 'progressions', 'entries', 'trainings', 'contexts', 'sessions']
views = ['show', 'index', 'display', 'list', 'list/item', 'form', 'new', 'edit', 'select', 'manager']

paths = [
  'shared/footer'
  'entity/list/empty'
  'entity/list/item/divider'
  'progressions/in_session'
  'entries/form/repetitions_picker'
  'entries/form/treadmill_picker'
  'contexts/choose'
]

for entity in entities
  for view in views
    paths.push "#{entity}/#{view}"

export default { paths }
