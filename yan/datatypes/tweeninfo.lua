--- Info type for Tweens
---@class TweenInfo
---@field duration number The length of the tween
---@field easingstyle fun(x: number): number The easing function to use in the tween. All common easing styles are pre-provided in the `EasingStyle` type
---@field reverses boolean If enabled, the tween will reverse after finishing playback
---@field repeatcount number Number of times the tween repeats after finishing
---@field delay number Seconds until the tween begins when `:play()` is called
TweenInfo = {}
TweenInfo.__index = TweenInfo

--- Creates a new TweenInfo
---@param duration number The length of the tween
---@param easingstyle? fun(x: number): number The easing function to use in the tween. All common easing styles are pre-provided in the `EasingStyle` type
---@param reverses? boolean If enabled, the tween will reverse after finishing playback
---@param repeatcount? number Number of times the tween repeats after finishing
---@param delay? number Seconds until the tween begins when `:play()` is called
---@return TweenInfo
function TweenInfo.new(duration, easingstyle, reverses, repeatcount, delay)
    local self = {
        duration = duration,
        easingstyle = easingstyle or EasingStyle.Linear,
        reverses = reverses or false,
        repeatcount = repeatcount or 0,
        delay = delay or 0
    }

    return self
end

return TweenInfo