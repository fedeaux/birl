# TODO: Auto generate paths

entities = ['groups', 'exercises', 'challenges', 'progressions', 'entries', 'trainings']
views = ['show', 'index', 'list', 'list/item', 'form', 'new', 'edit', 'select', 'manager']

paths = [
  'shared/footer'
  'entity/list/empty'
  'entity/list/item/divider'
]

for entity in entities
  for view in views
    paths.push "#{entity}/#{view}"

export default { paths }
