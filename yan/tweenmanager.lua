local tweenmanager = {}
tweenmanager.ActiveTweens = {}

local EasingStyle = require("yan.datatypes.easingstyle")

function tweenmanager:NewTweenInfo(duration, easingStyle)
    local tweenInfo = {
        Duration = duration or 1,
        EasingStyle = easingStyle or EasingStyle.Linear
    }

    return tweenInfo
end

function tweenmanager:NewTween(instance, tweeninfo, goal)
    local tween = {
        Instance = instance,
        TweenInfo = tweeninfo,
        Goal = goal,
        
        Progress = 0.0,
        TimePosition = 0.0,
        OriginalProperties = {},
        IsPlaying = false,
        Finished = false
    }
    
    for key, value in pairs(tween.Goal) do
        tween.OriginalProperties[key] = instance[key]
    end
    
    table.insert(self.ActiveTweens, tween)
    
    function tween:Play()
        tween.IsPlaying = true
    end

    return tween
end

local EasingFuncs = {
    [EasingStyle.Linear] = function (x)
        return x
    end,

    [EasingStyle.SineIn] = function (x)
        return 1 - math.cos((x * math.pi) / 2)
    end,

    [EasingStyle.SineOut] = function (x)
        return math.sin((x * math.pi))
    end,

    [EasingStyle.SineInOut] = function (x)
        return -(math.cos(math.pi * x) - 1) / 2
    end,
    [EasingStyle.CubicIn] = function (x)
        return x ^ 3
    end,
    [EasingStyle.CubicOut] = function (x)
        return 1 - math.pow(1 - x, 3)
    end,
    [EasingStyle.CubicInOut] = function (x)
        return (x < 0.5) and 4 * (x ^ 3) or 1 - math.pow(-2 * x + 2, 3) / 2
    end
}

local function UpdateTween(tween, dt)
    tween.TimePosition = tween.TimePosition + dt
    tween.Progress = tween.TimePosition / tween.TweenInfo.Duration
    
    for key, value in pairs(tween.Goal) do
        print(tostring(value))
        tween.Instance[key] = tween.OriginalProperties[key] + (value - tween.OriginalProperties[key]) * EasingFuncs[tween.TweenInfo.EasingStyle](tween.Progress)
    end

    if tween.Progress >= 1.0 then
        tween.Finished = true
        tween.IsPlaying = false
    end
end

function tweenmanager:Update(dt)
    for _, tween in ipairs(self.ActiveTweens) do
        if tween.IsPlaying and not tween.Finished then
            UpdateTween(tween, dt)
        end
    end
end

return tweenmanager