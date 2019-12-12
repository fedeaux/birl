# TODO: Auto generate paths

routes = [
    {
      path: ''
      view: 'sessions/today'
    }
  ]

add_rest = (routes, resource) ->
  routes.push
    path: "/#{resource}"
    view: "#{resource}/index"

  routes.push
    path: "/#{resource}/:id"
    view: "#{resource}/show"

  routes.push
    path: "/#{resource}/new"
    view: "#{resource}/new"

  routes.push
    path: "/#{resource}/:id/edit"
    view: "#{resource}/edit"

for resource in ['exercises', 'challenges', 'progressions', 'entries', 'trainings']
  add_rest routes, resource

export default { routes }
