import AbstractList from './abstract_list'
import BasicCromatisms from './basic_cromatisms'
import KyokushinKihonKicks from './kyokushin_kihon_kicks'
import SingDrillsCycle from './sing_drills_cycle'

class EntryGeneratorsMain
  constructor: ->
    @generators = {}

  register: (name, klass) ->
    @generators[name] = klass

  instantiate: (generator) ->
    new @generators[generator.name](generator.params)

  registerAll: ->
    @register 'abstract_list', AbstractList
    @register 'basic_cromatisms', BasicCromatisms
    @register 'kyokushin_kihon_kicks', KyokushinKihonKicks
    @register 'sing_drills_cycle', SingDrillsCycle

export default EntryGeneratorsMain
