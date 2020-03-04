import Board from './board'
import Shelf from './shelf'

export default class Bookshelf
  constructor: (@scene, options = {}) ->
    @setProperties options

  build: ->
    @buildWalls()
    @buildShelfs()
    @buildTopping()

  buildWalls: ->
    left_wall = @addBoard 'left_wall',
                          dimensions: { height: @height, width: @wall_thickness, depth: @depth - @inner_thickness },
                          position: { x:  - (@width - @wall_thickness) / 2 }

    right_wall = @addBoard 'right_wall',
                          dimensions: { height: @height, width: @wall_thickness, depth: @depth - @inner_thickness },
                          position: { x: (@width - @wall_thickness) / 2 }

    back_wall = @addBoard 'back_wall',
                          dimensions: { height: @height, width: @width, depth: @inner_thickness },
                          position: { z: @half_depth }

  buildShelfs: ->
    i = 0
    total_shelf_grow = ((shelf.grow || 1) for shelf in @shelfs).reduce(((a, b) -> a + b), 0)
    shelf_proportion = 1 / total_shelf_grow
    y_offset = @padding_bottom
    other_shelfs = []

    while i < @shelfs_count
      options = _.extend({ y_offset: y_offset, shelf_proportion: shelf_proportion, other_shelfs: other_shelfs }, @shelfs[@shelfs_count - 1 - i])
      shelf = (new Shelf(@, i, options)).build()
      y_offset += shelf.height
      other_shelfs.push shelf
      i += 1

  buildTopping: ->
    topping = @addBoard "topping",
                        dimensions: { height: @wall_thickness, width: @width, depth: @depth },
                        position: { x: 0, y: @half_height + @half_wall_thickness, z: @half_inner_thickness }

  setProperties: (options) ->
    for property, value of { scale: 1, width: null, depth: null, shelfs: [] }
      @[property] = options[property] or value

    for property, value of { height: 100, wall_thickness: 2.5, inner_thickness: 1.5, padding_bottom: 0, padding_top: 0 }
      @[property] = (options[property] or value) * @scale

    @shelfs_count = @shelfs.length
    @inner_height = @height - @padding_bottom - @padding_top
    @cell_height = @inner_height / @shelfs_count
    @inner_cell_height = @cell_height - @inner_thickness

    @width ?= @cell_height / 0.618 # From end to end
    @depth ?= @width * (1 - 0.618)

    @inner_width = @width - 2 * @wall_thickness
    @inner_depth = @depth - @inner_thickness
    @shelf_depth = @inner_depth - @inner_thickness

    for halvable in ['depth', 'height', 'wall_thickness', 'inner_thickness']
      @["half_#{halvable}"] = @[halvable] / 2

  addBoard: (name, options) ->
    new Board name, options, @scene
