--- A RGBA color value
---@class Color
---@field r number
---@field g number
---@field b number
---@field a number
Color = {}
Color.__index = Color

--- Creates a new Color, with values ranging from 0-1
---@param r number Red value from 0-1
---@param g number Green value from 0-1
---@param b number Blue value from 0-1
---@param a? number Alpha value from 0-1
---@return Color
function Color.new(r, g, b, a)
    local self = setmetatable({
        r = math.min(r, 1),
        g = math.min(g, 1),
        b = math.min(b, 1),
        a = math.min(a or 1, 1)
    }, Color)
    
    return self
end

--- Creates a new Color, with values ranging from 0-255
---@param r number Red value from 0-255
---@param g number Green value from 0-255
---@param b number Blue value from 0-255
---@param a? number Alpha value from 0-255
---@return Color
function Color.fromRgb(r, g, b, a)
    a = a or 255

    local self = setmetatable({
        r = math.min(r / 255, 1),
        g = math.min(g / 255, 1),
        b = math.min(b / 255, 1),
        a = math.min(a / 255, 1)
    }, Color)
    
    return self
end

--- Returns the RGBA values of the color, eg. to be used in `love.graphics.setColor`
---@return number, number, number, number
function Color:get()
    return self.r, self.g, self.b, self.a
end

function Color.__add(a, b)
    return Color.new(
        a.r + b.r,
        a.g + b.g,
        a.b + b.b,
        a.a + b.a
    )
end

function Color.__sub(a, b)
    return Color.new(
        a.r - b.r,
        a.g - b.g,
        a.b - b.b,
        a.a - b.a
    )
end

function Color.__mul(a, b)
    return Color.new(
        a.r * b,
        a.g * b,
        a.b * b,
        a.a * b
    )
end

return Color