local tweenmanager = {}
tweenmanager.ActiveTweens = {}

function tweenmanager:NewTweenInfo(duration)
    local tweenInfo = {
        Duration = duration
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

function tweenmanager:Update(dt)
    for _, tween in ipairs(self.ActiveTweens) do
        if tween.IsPlaying and not tween.Finished then
            tween.TimePosition = tween.TimePosition + dt
            tween.Progress = tween.TimePosition / tween.TweenInfo.Duration
            
            for key, value in pairs(tween.Goal) do
                tween.Instance[key] = tween.OriginalProperties[key] + (value - tween.OriginalProperties[key]) * tween.Progress
            end

            if tween.Progress >= 1.0 then
                tween.Finished = true
                tween.IsPlaying = false
            end
        end
    end
end

return tweenmanager