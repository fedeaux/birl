import Bookshelf from './furniturer/bookshelf'

export default class Furniturer
  constructor: (@scene) ->
    @loaded()

  loaded: ->
    (new Bookshelf(@scene, padding_bottom: 10, height: 300, width: 100, shelfs_count: 10)).build()
