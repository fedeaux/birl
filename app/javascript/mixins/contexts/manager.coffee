import ContextsResource from '../../resources/contexts_resource'
import Context from '../../models/context'

export default
  props:
    context:
      default: -> {}

    parent_contexts: null

  data: ->
    contexts: null
    form_context: null

  methods:
    contextAdded: (index, context) ->
      # console.log 'contextAdded', index, context

    getContext: (context_id) ->
      index = @contextIndex context_id
      return null if index == -1
      @contexts[index]

    editContext: (data) ->
      @setFormContext data.context

    destroyContext: (data) ->
      @contexts_resource.destroy data.context, @contextRemoved

    loadContexts: ->
      @contexts_resource.index @contextsLoaded, @context

    contextsLoaded: (response) ->
      @contexts = response.contexts

    newContext: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      @setFormContext new Context final_params

    setFormContext: (@form_context) ->
      @form_context

    clearFormContext: ->
      @setFormContext null

    contextIndex: (context_id) ->
      for index, context of @contexts
        return index if context.id == context_id

      -1

    saveFormContext: (custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @contextSaved(data)
          custom_callback(data)

        @contexts_resource.save @form_context, callback
        return

      @contexts_resource.save @form_context, @contextSaved

    addContext: (context) ->
      index = @contextIndex context.id

      if index == -1
        @contexts.unshift context
        index = 0

      else
        Vue.set @contexts, index, context

      @contextAdded index, context

    contextSaved: (data) ->
      @addContext data.context
      @clearFormContext()

    contextRemoved: (data) ->
      index = @contextIndex data.context.id
      return if index == -1
      @contexts.splice index, 1

  mounted: ->
    @contexts_resource = new ContextsResource

    if @parent_contexts
      @contexts = @parent_contexts
      return

    unless @context
      @loadContexts()

  watch:
    context:
      immediate: true
      handler: ->
        @contexts_resource ?= new ContextsResource
        @loadContexts()
