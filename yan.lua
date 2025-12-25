--[[                                
     _   _  __ _ _ __  
    | | | |/ _` | '_ \ 
    | |_| | (_| | | | |
    \__, |\__,_|_| |_|
     __/ |            
    |___/             


    A simple UI library for Love2D, based on Roblox's UI system and inspired by dphfox's Fusion.
    Made by @Nibbl-z 
    https://github.com/Nibbl-z/Yan
]]

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

--- Updates yan. Call this in `love.update`.
---@param dt number
function yan:update(dt)
    registry:update(dt)
end

--- Draws all screens. Call this in `love.draw`.
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