local Color = {}
Color.__index = Color

local utils = require("yan.utils")

function Color.new(r, g, b, a)
    local c = {R = r, G = g, B = b, A = a}
    setmetatable(c, Color)
    return c
end

function Color.__add(a, b)
    return Color.new(
        utils:Clamp(a.R + b.R, 0, 1),
        utils:Clamp(a.G + b.G, 0, 1),
        utils:Clamp(a.B + b.B, 0, 1),
        utils:Clamp(a.A + b.A, 0, 1)
    )
end

function Color.__sub(a, b)
    return Color.new(
        utils:Clamp(a.R - b.R, 0, 1),
        utils:Clamp(a.G - b.G, 0, 1),
        utils:Clamp(a.B - b.B, 0, 1),
        utils:Clamp(a.A - b.A, 0, 1)
    )
end

function Color.__mul(a, b)
    return Color.new(
        utils:Clamp(a.R * b, 0, 1),
        utils:Clamp(a.G * b, 0, 1),
        utils:Clamp(a.B * b, 0, 1),
        utils:Clamp(a.A * b, 0, 1)
    )
end

function Color.__tostring(v)
    return tostring(v.R).." "..tostring(v.G).." "..tostring(v.B).." "..tostring(v.A)
end


return Color