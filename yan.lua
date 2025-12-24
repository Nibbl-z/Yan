yan = {}

uibase = require "yan.uibase"
textlabel = require "yan.textlabel"
textinput = require "yan.textinput"
imagelabel = require "yan.imagelabel"
screen = require "yan.screen"
tween = require "yan.tween"
UDim2 = require "yan.datatypes.udim2"
UDim = require "yan.datatypes.udim"
Color = require "yan.datatypes.color"
Vector2 = require "yan.datatypes.vector2"
EasingStyle = require "yan.datatypes.easingstyle"
TweenInfo = require "yan.datatypes.tweeninfo"

local registry = require "yan.registry"

--- Draws all screens. Call this in `love.draw`.
function yan:update(dt)
    registry:update(dt)
end

--- Updates yan. Call this in `love.update`.
function yan:draw()
    registry:draw()
end

--- Handles all text input. Call this in `love.textinput`.
---@param text string
function yan:textinput(text)
    registry:textinput(text)
end

--- Handles all key presses. Call this in `love.keypressed`.
---@param key string
function yan:keypressed(key)
    registry:keypressed(key)
end

return yan