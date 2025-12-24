EasingStyle = {
    Linear = function (x)
        return x
    end,

    SineIn = function (x)
        return 1 - math.cos((x * math.pi) / 2)
    end,
    SineOut = function (x)
        return math.sin((x * math.pi))
    end,
    SineInOut = function (x)
        return -(math.cos(math.pi * x) - 1) / 2
    end,
    
    CubicIn = function (x)
        return x ^ 3
    end,
    CubicOut = function (x)
        return 1 - math.pow(1 - x, 3)
    end,
    CubicInOut = function (x)
        return (x < 0.5) and 4 * (x ^ 3) or 1 - math.pow(-2 * x + 2, 3) / 2
    end,
    
    QuintIn = function (x)
        return x ^ 5
    end,
    QuintOut = function (x)
        return 1 - math.pow(1 - x, 5)
    end,
    QuintInOut = function (x)
        return (x < 0.5) and 16 * (x ^ 5) or 1 - math.pow(-2 * x + 2, 5) / 2
    end,
    
    CircularIn = function (x)
        if x == 1 then return 1 end
        return 1 - math.sqrt(1 - x ^ 2)
    end,
    CircularOut = function (x)
        return math.sqrt(1 - math.pow(x - 1, 2))
    end,
    CircularInOut = function (x)
        return (x < 0.5)
        and (1 - math.sqrt(1 - math.pow(2 * x, 2))) / 2
        or (math.sqrt(1 - math.pow(-2 * x + 2, 2)) + 1) / 2;
    end,

    QuadIn = function (x)
        return x ^ 2
    end,
    QuadOut = function (x)
        return 1 - (1 - x) * (1 - x)
    end,
    QuadInOut = function (x)
        return (x < 0.5) and 2 * x * x or 1 - math.pow(-2 * x + 2, 2) / 2
    end,

    QuartIn = function (x)
        return x ^ 4
    end,
    QuartOut = function (x)
        return 1 - math.pow(1 - x, 4)
    end,
    QuartInOut = function (x)
        return (x < 0.5) and 8 * x ^ 4 or 1 - math.pow(-2 * x + 2, 4) / 2
    end,

    ExponentialIn = function (x)
        return x == 0 and 0 or math.pow(2, 10 * x - 10)
    end,
    ExponentialOut = function (x)
        return x == 1 and 1 or 1 - math.pow(2, -10 * x)
    end,
    ExponentialInOut = function (x)
        if x == 0 then return 0 end
        if x == 1 then return 1 end
        
        return (x < 0.5) and math.pow(2, 20 * x - 10) / 2 or (2 - math.pow(2, -20 * x + 10)) / 2
    end,

    BackIn = function (x)
        local c1 = 1.70158
        local c3 = c1 + 1
        
        return c3 * x ^ 3 - c1 * x ^ 2
    end,
    BackOut = function (x)
        local c1 = 1.70158
        local c3 = c1 + 1
        return 1 + c3 * math.pow(x - 1, 3) + c1 * math.pow(x - 1, 2)
    end,
    BackInOut = function (x)
        local c1 = 1.70158
        local c2 = c1 * 1.525
        
        return (x < 0.5) and (math.pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2 or (math.pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2
    end,

    ElasticIn = function (x)
        local c4 = (2 * math.pi) / 3
        
        if x == 0 then return 0 end
        if x == 1 then return 1 end

        return -math.pow(2, 10 * x - 10) * math.sin((x * 10 - 10.75) * c4)
    end,
    ElasticOut = function (x)
        local c4 = (2 * math.pi) / 3

        if x == 0 then return 0 end
        if x == 1 then return 1 end

        return math.pow(2, -10 * x) * math.sin((x * 10 - 0.75) * c4) + 1
    end,
    ElasticInOut = function (x)
        local c5 = (2 * math.pi) / 4.5

        if x == 0 then return 0 end
        if x == 1 then return 1 end
        return (x < 0.5) and -(math.pow(2, 20 * x - 10) * math.sin((20 * x - 11.125) * c5)) / 2 or (math.pow(2, -20 * x + 10) * math.sin((20 * x - 11.125) * c5)) / 2 + 1
    end,
    
    BounceOut = function (x)
        local n1 = 7.5625
        local d1 = 2.75
        
        if x < 1 / d1 then
            return n1 * x ^ 2
        elseif x < 2 / d1 then
            x = x - 1.5 / d1
            return n1 * x * x + 0.75
        elseif x < 2.5 / d1 then
            x = x - 2.25 / d1
            return n1 * x * x + 0.9375
        else
            x = x - 2.625 / d1
            return n1 * x * x + 0.984375
        end
    end,
    BounceIn = function (x)
        local function bounceout(x)
            local n1 = 7.5625
            local d1 = 2.75
            
            if x < 1 / d1 then
                return n1 * x ^ 2
            elseif x < 2 / d1 then
                x = x - 1.5 / d1
                return n1 * x * x + 0.75
            elseif x < 2.5 / d1 then
                x = x - 2.25 / d1
                return n1 * x * x + 0.9375
            else
                x = x - 2.625 / d1
                return n1 * x * x + 0.984375
            end
        end
        return 1 - bounceout(1 - x)
    end,
    BounceInOut = function (x)
        local function bounceout(x)
            local n1 = 7.5625
            local d1 = 2.75
            
            if x < 1 / d1 then
                return n1 * x ^ 2
            elseif x < 2 / d1 then
                x = x - 1.5 / d1
                return n1 * x * x + 0.75
            elseif x < 2.5 / d1 then
                x = x - 2.25 / d1
                return n1 * x * x + 0.9375
            else
                x = x - 2.625 / d1
                return n1 * x * x + 0.984375
            end
        end
        
        return (x < 0.5) and (1 - bounceout(1 - 2 * x)) / 2 or (1 + bounceout(2 * x - 1)) / 2
    end
}

return EasingStyle