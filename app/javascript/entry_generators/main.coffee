import SingDrillsCycle from './sing_drills_cycle'
import BasicCromatisms from './basic_cromatisms'

class EntryGeneratorsMain
  constructor: ->
    @generators = {}

  register: (name, klass) ->
    @generators[name] = klass

  instantiate: (generator) ->
    new @generators[generator.name](generator.params)

  registerAll: ->
    @register 'sing_drills_cycle', SingDrillsCycle
    @register 'basic_cromatisms', BasicCromatisms

export default EntryGeneratorsMain
