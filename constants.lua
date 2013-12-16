constants = {}

-- Debug mode: show hitboxes, and have lots of health
constants.debug = true

constants.playTime = 160
constants.jumpTime = 100
constants.framerate = 30
constants.frameDuration = 1 / constants.framerate

constants.windowWidth = 800
constants.windowHeight = 600

-- Z levels
constants.z = {level={}}
constants.z.min = 0
constants.z.max = 1
constants.z.level.scenery = 0
constants.z.level.entities = 1

-- constants.controls.<control>.<key> = true
constants.controls = {jump={}, left={}, right={}, shoot={}}
constants.controls.jump.w = true
constants.controls.jump.up = true
constants.controls.left.a = true
constants.controls.left.left = true
constants.controls.right.d = true
constants.controls.right.right = true
constants.controls.shoot.space = true

return constants
