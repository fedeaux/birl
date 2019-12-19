import SingDrillsCycle from './sing_drills_cycle'

class EntryGeneratorsMain
  constructor: ->
    @generators = {}

  register: (name, klass) ->
    @generators[name] = klass

  instantiate: (generator) ->
    new @generators[generator.name](generator.params)

  registerAll: ->
    @register 'sing_drills_cycle', SingDrillsCycle

export default EntryGeneratorsMain
