constants = {}

constants.playTime = 140
constants.jumpTime = 100
constants.framerate = 30
constants.frameDuration = 1 / constants.framerate

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
