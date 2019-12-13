# TODO: Auto generate paths

entities = ['groups', 'exercises', 'challenges', 'progressions', 'entries', 'trainings', 'sessions']
views = ['show', 'index', 'list', 'list/item', 'form', 'new', 'edit', 'select', 'manager']

paths = [
  'shared/footer'
  'entity/list/empty'
  'entity/list/item/divider'
  'entries/list/item/contents'
  'progressions/in_session'
]

for entity in entities
  for view in views
    paths.push "#{entity}/#{view}"

export default { paths }
