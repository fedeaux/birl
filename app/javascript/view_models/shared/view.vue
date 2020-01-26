<script lang="coffee">
  resolveParamsToAtts = (params, props) ->
    attrs = {}

    for name, options of props
      if params[name]
        attrs[name] = options.type and options.type(params[name]) or params[name]

    attrs

  export default
    props: ['path']

    functional: true

    render: (_, options) ->
      parent = options.parent
      resolved = parent.$router.resolve(options.props.path)
      component = resolved.resolved.matched[0].components.default
      params = resolved.route.params
      data = { attrs: resolveParamsToAtts params, component.props }

      parent.$createElement component, data
</script>
