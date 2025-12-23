yan = {}

uibase = require "yan.uibase"
textlabel = require "yan.textlabel"
textinput = require "yan.textinput"
imagelabel = require "yan.imagelabel"
screen = require "yan.screen"
UDim2 = require "yan.datatypes.udim2"
UDim = require "yan.datatypes.udim"
Color = require "yan.datatypes.color"
Vector2 = require "yan.datatypes.vector2"

local manager = require "yan.manager"

--- Draws all screens. Call this in `love.draw`.
function yan:update()
    manager:update()
end

--- Updates yan. Call this in `love.update`.
function yan:draw()
    manager:draw()
end

--- Handles all text input. Call this in `love.textinput`.
---@param text string
function yan:textinput(text)
    manager:textinput(text)
end

--- Handles all key presses. Call this in `love.keypressed`.
---@param key string
function yan:keypressed(key)
    manager:keypressed(key)
end

return yan