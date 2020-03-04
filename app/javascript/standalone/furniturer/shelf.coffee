import Board from './board'

export default class Shelf
  constructor: (@bookshelf, @i, @options = {}) ->
    @setProperties()

  build: ->
    @height = @shelf_proportion * @grow * @bookshelf.inner_height
    @inner_height = @height - @inner_thickness
    @shelf_y =  - @bookshelf.half_height + @bookshelf.half_inner_thickness + @y_offset
    @mid_shelf_y = @shelf_y + @height / 2

    shelf = @bookshelf.addBoard "shelf_#{@i}",
                                dimensions:
                                  height: @inner_thickness
                                  width: @inner_width
                                  depth: @shelf_depth

                                position:
                                  x: 0
                                  y: @shelf_y
                                  z: @bookshelf.half_inner_thickness

    if @cells
      for cell in @cells
        cell.grow ?= 1

      j = 0

      total_cell_grow = (cell.grow for cell in @cells).reduce(((a, b) -> a + b), 0)
      cell_proportion = 1 / total_cell_grow
      accumulated_cell_grow = 0

      while j < @cells.length
        cell = @cells[j]
        mid_cell_x = @inner_width * (-0.5 + cell_proportion * (accumulated_cell_grow + cell.grow/2))

        accumulated_cell_grow += cell.grow
        @bookshelf.addBoard "cell_#{@i}_#{j}",
                            dimensions:
                              height: @inner_height
                              width: @inner_thickness
                              depth: @shelf_depth

                            position:
                              x: @inner_width * (-0.5 + cell_proportion * accumulated_cell_grow)
                              y: @mid_shelf_y
                              z: @half_inner_thickness

        if cell.door
          cell.door.span ?= 1
          door_width = @inner_width * cell_proportion * cell.grow - @half_inner_thickness

          if cell.door.angle and cell.door.angle >= Math.PI * .5 or mid_cell_x > 0
            cell.door.angle ?= Math.PI * 2/3
            angle_x_offset = door_width * (1 - Math.abs(Math.cos cell.door.angle)) / 2
          else
            cell.door.angle ?= Math.PI/3
            angle_x_offset = - door_width * (1 - Math.abs(Math.cos cell.door.angle)) / 2

          base_door_height = @height
          base_door_y = @mid_shelf_y

          for k in [1...cell.door.span]
            base_door_height += @other_shelfs[@i - k].height
            base_door_y -= @other_shelfs[@i - k].height / 2

          angle_z_offest = - door_width * (Math.sin cell.door.angle) / 2

          @bookshelf.addBoard "door_#{@i}",
                              dimensions:
                                height: base_door_height - @inner_thickness
                                width: door_width
                                depth: @inner_thickness

                              position:
                                x: mid_cell_x + angle_x_offset
                                y: base_door_y
                                z: angle_z_offest - @bookshelf.half_depth + @bookshelf.inner_thickness

                              rotation:
                                y: cell.door.angle

        j += 1

    @

  setProperties: (options) ->
    for property, value of { grow: 1 }
      @[property] = @options[property] or value

    for property in ['width', 'inner_width', 'inner_thickness', 'shelf_depth', 'half_inner_thickness' ]

      @[property] = @bookshelf[property]

    for property in [ 'cells', 'y_offset', 'shelf_proportion', 'other_shelfs' ]
      @[property] = @options[property]

    # @inner_door_height = @cell_height - @inner_thickness / 3
