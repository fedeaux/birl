export default class Board
  constructor: (@name, @options, @scene) ->
    @mesh = BABYLON.MeshBuilder.CreateBox @name, @options.dimensions, @scene
    @mesh.material = @woodMaterial()

    for option in ['position', 'rotation']
      if @options[option]
        for key, value of @options[option]
          @mesh[option][key] = value

  woodMaterial: ->
    woodMaterial = new BABYLON.StandardMaterial 'wood', @scene
    woodMaterial.diffuseColor = new BABYLON.Color3(1, 0, 1)
    woodMaterial.specularColor = new BABYLON.Color3(0.5, 0.6, 0.87)
    woodMaterial.emissiveColor = new BABYLON.Color3(1, 1, 1)
    woodMaterial.ambientColor = new BABYLON.Color3(0.23, 0.98, 0.53)

    woodTexture = new BABYLON.WoodProceduralTexture("wood-texture", 512, @scene)
    woodTexture.ampScale = @options.dimensions.height * 16

    woodMaterial.diffuseTexture = woodTexture
    woodMaterial
