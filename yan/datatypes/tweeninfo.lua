--- Info type for Tweens
---@class TweenInfo
---@field duration number The length of the tween
---@field easingstyle fun(x: number): number The easing function to use in the tween. All common easing styles are pre-provided in the `EasingStyle` type.
TweenInfo = {}
TweenInfo.__index = TweenInfo

--- Creates a new TweenInfo
---@param duration number The length of the tween
---@param easingstyle? fun(x: number): number The easing function to use in the tween. All common easing styles are pre-provided in the `EasingStyle` type.
function TweenInfo.new(duration, easingstyle)
    local self = {
        duration = duration,
        easingstyle = easingstyle or EasingStyle.Linear
    }

    return self
end

return TweenInfo