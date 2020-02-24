# TODO: Auto generate paths

routes = [
  {
    path: ''
    view: 'home'
  },
  {
    path: '/'
    view: 'home'
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
  },
  {
    path: '/questioner'
    view: 'questioner/index'
  },
  {
    path: '/tools'
    view: 'tools/index'
  },
  {
    path: '/contexts/choose'
    view: 'contexts/choose'
  },
  {
    path: '/timelogs/today'
    view: 'timelogs/today'
  },
  {
    path: '/timelogs/week'
    view: 'timelogs/week'
  }
]

singularResource = (resource) ->
  resource[0..-2]

add_rest = (routes, resource) ->
  singular_resource = singularResource resource

  routes.push
    path: "/#{resource}/new"
    view: "#{resource}/new"

  routes.push
    path: "/#{resource}"
    view: "#{resource}/index"

  routes.push
    path: "/#{resource}/:#{singular_resource}_id"
    view: "#{resource}/show"

  routes.push
    path: "/#{resource}/:#{singular_resource}_id/edit"
    view: "#{resource}/edit"

for resource in ['exercises', 'challenges', 'progressions', 'entries', 'trainings', 'sessions', 'contexts', 'listers', 'session_progressions', 'vocabularies', 'timelogs', 'tags', 'memes']
  add_rest routes, resource

export default { routes }
