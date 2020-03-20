window._ = require 'underscore'

import * as BABYLON from 'babylonjs'
import 'babylonjs-procedural-textures'

window.$ = require 'jquery'
window.jQuery = window.$

import Furniturer from '../standalone/furniturer'

class Standalone3dEngine
  constructor: ->
    canvas = document.getElementById 'board'
    engine = new BABYLON.Engine(canvas, true)

    # Create the scene space
    @scene = new (BABYLON.Scene)(engine)
    # Add a camera to the scene and attach it to the canvas
    # Parameters: name, position, scene
    #
    camera = new BABYLON.ArcRotateCamera("Camera", Math.PI * 3/2, Math.PI/2, 200, new BABYLON.Vector3.Zero(), @scene)
    camera.attachControl(canvas, true)
    #camera = new (BABYLON.FreeCamera)('camera', new (BABYLON.Vector3)(0, 100, -100), @scene)
    #camera.setTarget(BABYLON.Vector3.Zero())

    # # The goal distance of camera from target
    # camera.radius = 300000
    # # The goal height of camera above local origin (centre) of target
    # camera.heightOffset = 100000
    # # The goal rotation of camera around local origin (centre) of target in x y plane
    # camera.rotationOffset = 0
    # # Acceleration of camera in moving from current to goal position
    # camera.cameraAcceleration = 1
    # # The speed at which acceleration is halted
    # camera.maxCameraSpeed = 10
    # # This attaches the camera to the canvas
    # # camera.attachControl canvas, true

    # Add lights to the scene
    light1 = new (BABYLON.HemisphericLight)('light1', new (BABYLON.Vector3)(1, 1, 0), @scene)
    light2 = new (BABYLON.PointLight)('light2', new (BABYLON.Vector3)(0, 100, -100), @scene)
    # Add and manipulate meshes in the scene

    @furniturer = new Furniturer @scene

    engine.runRenderLoop =>
      @scene.render()

    window.addEventListener 'resize', =>
      @engine.resize()

$ ->
  if $('#furniturer').length > 0
    new Standalone3dEngine()

  # if $('#math-board').length > 0
  #   Mathjax.init(loader: load: [
  #     'input/tex'
  #     'output/svg'
  #   ]).then((MathJax) ->
  #     svg = MathJax.tex2svg('\\frac{1}{x^2-1}', display: true)
  #     console.log MathJax.startup.adaptor.outerHTML(svg)
  #     console.log 'buceta'
  #   ).catch (err) ->
  #     console.log err.message
