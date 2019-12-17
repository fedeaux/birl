class BaseModel
  isModel: true

  constructor: (attrs = {}) ->
    for name, value of @constructor.attributes()
      @setAttribute name, attrs[name]

    @tmp_id = @generateTmpId()

  generateTmpId: ->
    return @id if @id

    prefix = @member().toString()
    timestamp = (new Date()).valueOf()
    random = Math.floor(Math.random() * Math.floor(99999))

    "#{prefix}-#{timestamp}-#{random}"

  collection: ->
    @constructor.collection

  member: ->
    @constructor.member

  path: ->
    "/#{@collection()}/#{@id}"

  collectionPath: ->
    "/#{@collection()}"

  editPath: ->
    "/#{@collection()}/#{@id}/edit"

  isNewRecord: ->
    ! @id

  isPersisted: ->
    ! @isNewRecord()

  serialize: ->
    serialized = {}

    for name, value of @serializableAttributes()
      serialized[name] = @serializeAttribute @[name], name

    serialized

  serializeForSave: ->
    @serialize()

  serializeAttribute: (value, name) ->
    return value unless value
    return (@serializeAttribute(v, name) for v in value) if _.isArray value
    return value.format() if value._isAMomentObject
    return value.serialize() if value.isModel
    return @serializeObject(value) if _.isObject value
    value

  serializeObject: (obj) ->
    serialized = {}

    for key, value of obj
      serialized[key] = @serializeAttribute value, key

    serialized

  serializableAttributes: ->
    if @constructor.serializableAttributes
      return @constructor.serializableAttributes()

    @constructor.attributes()

  setAttribute: (name, value) ->
    attribute = @constructor.attributes()[name]

    if value is undefined and attribute.default isnt undefined
      value = attribute.default

    if attribute.type or attribute.types
      return unless value

      if attribute.type
        model = attribute.type
      else
        model = (type for type in attribute.types when type.class_name == value.type)[0]

      unless model
        console.error "Cannot infer type for #{name}=#{value}. Assigning null instead."
        return

      if Array.isArray value
        @[name] = (new model v for v in value)

      else
        @[name] = new model value

    else
      @[name] = value

  clone: ->
    new @constructor @serialize()

  signature: ->
    JSON.stringify @serialize()

export default BaseModel
