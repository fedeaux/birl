import Board from './furniturer/board'

export default class Furniturer
  constructor: (@scene) ->
    @loaded()

  loaded: ->
    # @environment = @scene.createDefaultEnvironment(enableGroundShadow: true)
    # @environment.setMainColor babylon.Color3.White()
    # @environment.ground.position.y += 0.01

    shelfs_count = 8
    height = 204
    thickness = 1.5
    padding_bot = 5

    cell_height = (height - thickness - padding_bot) / (shelfs_count - 1)
    width = cell_height / 0.618
    depth = 20

    half_depth = depth / 2
    half_height = height / 2
    half_thick = thickness / 2
    half_width = width / 2

    left_wall = @addBoard 'left_wall',
                          dimensions: { height: height, width: thickness, depth: depth - thickness },
                          position: { x:  - (width - thickness) / 2 }

    right_wall = @addBoard 'right_wall',
                          dimensions: { height: height, width: thickness, depth: depth - thickness },
                          position: { x: (width - thickness) / 2 }

    back_wall = @addBoard 'back_wall',
                          dimensions: { height: height, width: width, depth: thickness },
                          position: { z: half_depth }

    i = 0
    divisor_x_position = [width * (0.618 - 0.5), width * (0.5 - 0.618)]
    door_x_position = [width * (0.618 - 0.5) + width * 0.618 / 2 - width * 0.618, width * 0.618 - width * (0.618 - 0.5) - width * 0.618 / 2]

    while i < shelfs_count
      shelf_y =  - half_height + cell_height * i + half_thick + padding_bot

      shelf = @addBoard "shelf_#{i}",
                        dimensions: { height: thickness, width: width - thickness * 2, depth: depth - thickness * 2 },
                        position: { x: 0, y: shelf_y, z: half_thick }

      if i < shelfs_count - 2
        divisor = @addBoard "divisor_#{i}",
                            dimensions: { height: cell_height - thickness, width: thickness, depth: depth - thickness * 2 },
                            position: { x: divisor_x_position[i % 2], y: shelf_y + cell_height / 2, z:  half_thick }

      if i == 0 or i == 2 or i == 5
        door = @addBoard "door_#{i}",
                         dimensions: { height: cell_height, width: width * 0.618, depth: thickness },
                         position: { x: door_x_position[i % 2], y: shelf_y + cell_height / 2, z: - half_depth + thickness }

      i += 1

  addBoard: (name, options) ->
    new Board name, options, @scene
