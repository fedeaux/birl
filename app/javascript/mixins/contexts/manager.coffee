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
    add_new: 'before'

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
      @contexts_resource ?= new ContextsResource

      if @parent_contexts
        @contextsLoaded contexts: @parent_contexts
        return

      @contexts_resource.index @contextsLoaded, @context

    contextsLoaded: (response) ->
      @contexts = response.contexts

    buildContext: (params = {}) ->
      final_params = JSON.parse JSON.stringify @context

      for key, value of params
        final_params[key] = value

      new Context final_params

    newContext: (params = {}) ->
      @setFormContext @buildContext params

    setFormContext: (@form_context) ->
      @form_context

    clearFormContext: ->
      @setFormContext null

    contextIndex: (context_id) ->
      for index, context of @contexts
        return index if context.id == context_id

      -1

    saveContext: (context, custom_callback = false) ->
      if custom_callback
        callback = (data) =>
          @contextSaved(data)
          custom_callback(data)

        @contexts_resource.save context, callback
        return

      @contexts_resource.save context, @contextSaved

    saveFormContext: (custom_callback = false) ->
      @saveContext @form_context, custom_callback

    createContext: (attributes, custom_callback = false) ->
      @saveContext @buildContext(attributes), custom_callback

    addContext: (context) ->
      index = @contextIndex context.id

      if index == -1
        if @add_new == 'before'
          @contexts.unshift context
          index = 0
        else
          @contexts.push context
          index = @contexts.length - 1

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

  watch:
    context:
      immediate: true
      handler: ->
        @loadContexts()
