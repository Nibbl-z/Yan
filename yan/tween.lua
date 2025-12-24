--- An animation that can smoothly transition a value to another
---@class Tween
---@field element UIBase The element to tween
---@field tweeninfo TweenInfo Information for the tween. Create with `TweenInfo.new`
---@field props table Table of properties to tween to
---@field _originalValues table
---@field _isplaying boolean Is the tween currently playing?
---@field _progress number
tween = {}
tween.__index = tween

local registry = require "yan.registry"

--- Creates a new Tween
---@param element UIBase The element to tween
---@param tweeninfo TweenInfo Information for the tween. Create with `TweenInfo.new`
---@param props table Table of properties to tween to
---@return Tween
function tween:new(element, tweeninfo, props)
    local object = {
        element = element,
        tweeninfo = tweeninfo,
        props = props,

        _isplaying = false,
        _originalValues = {},
        _progress = 0.0
    }

    setmetatable(object, self)

    registry:addtween(object)

    return object
end

function tween:play()
    if self._progress == 0.0 then
        for k, _ in pairs(self.props) do
            self._originalValues[k] = self.element[k]
        end
        
        self._progress = 0.0
    end
    self._isplaying = true
    
end

function tween:pause()
    self._isplaying = false
end

function tween:cancel()
    self._isplaying = false
    self._progress = 0.0

    for k, _ in pairs(self.props) do
        self.element[k] = self._originalValues[k]
    end
end

function tween:_update(dt)
    if self._isplaying then    
        self._progress = self._progress + dt
        local easeMod = self.tweeninfo.easingstyle(self._progress / self.tweeninfo.duration)
    
        for k, v in pairs(self.props) do
            self.element[k] = self._originalValues[k] + (v - self._originalValues[k]) * easeMod
        end

        if self._progress >= self.tweeninfo.duration then
            self._isplaying = false
            self._progress = 0.0
        end
    end
end

return tween