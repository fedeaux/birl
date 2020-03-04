import Bookshelf from './furniturer/bookshelf'

export default class Furniturer
  constructor: (@scene) ->
    @loaded()

  loaded: ->
    shelfs = {
      big: (new Bookshelf(@scene, padding_bottom: 10, height: 100, width: 100, shelfs: [
                            { cells: [{ door: {} }, {}, {}] },
                            { cells: [{ door: {} }, {}, {}, {}] },
                            { cells: [{ door: {} }, {}, {}, {}, {}] },
                            { cells: [{ door: {} }, {}, {}, {}, {}, {}] },
                          ]))

      exponential: (new Bookshelf(@scene, padding_bottom: 10, height: 100, width: 100, shelfs: [
                            { cells: [{}, {}] },
                            { cells: [{}, {}, {}, {}] },
                            { cells: [{}, {}] },
                            { cells: [{}, {}, {}, {}] },
                            { cells: [{}, {}, {}, {}, {}, {}, {}, {}] },
                          ]))

      grow: (new Bookshelf(@scene, padding_bottom: 10, height: 100, width: 100, shelfs: [
                            {},
                            { cells: [{}] },
                            { cells: [{}, {}] },
                            { cells: [{ grow: 2 }, {}] },
                            { cells: [{ grow: 3 }, {}] },
                            { cells: [{ grow: 4 }, {}] },
                            { cells: [{ grow: 5 }, {}] },
                            { cells: [{ grow: 6 }, {}] },
                            { cells: [{ grow: 7 }, {}] },
                          ]))

      exp_grow: (new Bookshelf(@scene, padding_bottom: 10, height: 100, width: 100, shelfs: [
                            {},
                            { cells: [{}] },
                            { cells: [{ grow: 2 }, {}] },
                            { cells: [{ grow: 4 }, { grow: 2 }, {}] },
                            { cells: [{ grow: 8 }, { grow: 4 }, { grow: 2 }, {}] },
                            { cells: [{ grow: 16 }, { grow: 8 }, { grow: 4 }, { grow: 2 }, {}] },
                          ]))

      golden: (new Bookshelf(@scene, padding_bottom: 10, height: 100, width: 100, shelfs: [
                              {},
                              { cells: [{ grow: 0.618, door: {} }, { grow: (1 - 0.618) }] },
                            ]))

      doors: (new Bookshelf(@scene, padding_bottom: 10, height: 100, width: 100, shelfs: [
                                   { cells: [{ grow: 0.618, door: {} }, { grow: (1 - 0.618) }] },
                                   { cells: [{ grow: 0.618 }, { grow: (1 - 0.618), door: {} }] },
                                   { cells: [{ grow: 0.618, door: {} }, { grow: (1 - 0.618), door: {} }] },
                                   { cells: [{ grow: 1, door: {} }, { grow: 2 }, { grow: 1 }, { grow: 2, door: {} }] },
                                 ]))

      grow_shelf: (new Bookshelf(@scene, padding_bottom: 10, height: 160, width: 100, shelfs: [
                              { grow: 1, cells: [{}, {}, { grow: 2, door: {}}] }
                              { grow: 1 }
                              { grow: 1 }
                              { grow: 2, cells: [{ grow: 3, door: {}}, {}, { grow: 2, door: {}}] }
                              { grow: 3, cells: [{}, { door: {} }, { grow: 3 }, { grow: 2, door: {}}] }
                            ]))

      sala: (new Bookshelf(@scene, padding_bottom: 10, height: 160, width: 160, shelfs: [
                              { grow: 1, cells: [{ door: { span: 3 }}, { door: { span: 3 }}]}
                              { grow: 1, cells: [{}, {}]}
                              { grow: 1, cells: [{}, {}]}
                            ]))
    }

    shelf = new URL(window.location).searchParams.get "shelf"
    shelfs[shelf].build() if shelfs[shelf]
