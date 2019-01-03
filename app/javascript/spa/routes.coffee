import raw_routes from './raw_routes'

componentize = (raw_route) ->
  raw_route.component = require("view_models/#{raw_route.view}").default
  raw_route.name ||= raw_route.view.replace(/\//g, '-').replace /_/g, '-'
  delete raw_route.view

  raw_route.children = (componentize(child) for child in raw_route.children) if raw_route.children
  raw_route

export default (componentize(raw_route) for raw_route in raw_routes.routes)
