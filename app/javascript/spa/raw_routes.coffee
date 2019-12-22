# TODO: Auto generate paths

routes = [
  {
    path: '/'
    view: 'contexts/choose'
  },
  {
    path: '/today'
    view: 'sessions/today'
  },
  {
    path: '/progressions/:id/execute'
    view: 'progressions/execute'
  },
  {
    path: '/audios'
    view: 'audios/index'
  }
]

add_rest = (routes, resource) ->
  routes.push
    path: "/#{resource}/new"
    view: "#{resource}/new"

  routes.push
    path: "/#{resource}"
    view: "#{resource}/index"

  routes.push
    path: "/#{resource}/:id"
    view: "#{resource}/show"

  routes.push
    path: "/#{resource}/:id/edit"
    view: "#{resource}/edit"

for resource in ['exercises', 'challenges', 'progressions', 'entries', 'trainings', 'sessions', 'contexts', 'listers', 'session_progressions']
  add_rest routes, resource

export default { routes }
