--- An animation that can smoothly transition a value to another
---@class Tween
---@field element UIBase The element to tween
---@field tweeninfo TweenInfo Information for the tween. Create with `TweenInfo.new`
---@field props table Table of properties to tween to
---@field _originalValues table
---@field _isplaying boolean If true, the tween is currently playing
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
    
    for k, v in pairs(props) do
        if type(v) ~= "number" and type(v) ~= "table" then
            props[k] = nil
        end

        if type(element[k]) ~= "number" and type(element[k]) ~= "table" then
            props[k] = nil
        end
    end

    local object = {
        element = element,
        tweeninfo = tweeninfo,
        props = props,

        _isplaying = false,
        _originalValues = {},
        _progress = -tweeninfo.delay,
        _repeats = 0,
        _reversing = false
    }

    setmetatable(object, self)

    registry:addtween(object)

    return object
end

--- Plays the tween
function tween:play()
    if self._isplaying then return end

    if self._progress <= 0 then
        for k, _ in pairs(self.props) do
            self._originalValues[k] = self.element[k]
        end
        
        self._progress = -self.tweeninfo.delay
        self._repeats = 0
        self._reversing = false
    end

    self._isplaying = true
end

--- Pauses the tween. Can be continued through `:play()`
function tween:pause()
    self._isplaying = false
end

--- Cancels the tween, and resets the element to its default values
function tween:cancel()
    self._isplaying = false
    self._progress = -self.tweeninfo.delay
    self._repeats = 0
    self._reversing = false

    for k, _ in pairs(self.props) do
        if self._originalValues[k] ~= nil then
            self.element[k] = self._originalValues[k]
        end
    end
end

--- Updates the tween
---@param dt number
function tween:_update(dt)
    if self._isplaying then
        self._progress = self._progress + dt * (self._reversing and -1 or 1)
        local easeMod = self.tweeninfo.easingstyle(math.max(self._progress, 0) / self.tweeninfo.duration)
    
        for k, v in pairs(self.props) do
            self.element[k] = self._originalValues[k] + (v - self._originalValues[k]) * easeMod
        end

        if self._progress >= self.tweeninfo.duration or (self._progress <= 0 and self._reversing) then
            if self.tweeninfo.reverses and not self._reversing then
                self._reversing = true
                self._progress = self.tweeninfo.duration
            else
                if self._repeats < self.tweeninfo.repeatcount then
                    self._repeats = self._repeats + 1
                    self._progress = 0.0
                    self._reversing = false
                else
                    self._isplaying = false
                    self._progress = -self.tweeninfo.delay
                    self._reversing = false
                end
            end
        end
    end
end

return tween