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
function Color.new(r, g, b, a)
    local self = setmetatable({
        r = r,
        g = g,
        b = b,
        a = a or 1
    }, Color)
    
    return self
end

--- Creates a new Color, with values ranging from 0-255
---@param r number Red value from 0-255
---@param g number Green value from 0-255
---@param b number Blue value from 0-255
---@param a? number Alpha value from 0-255
function Color.fromRgb(r, g, b, a)
    a = a or 255

    local self = setmetatable({
        r = r / 255,
        g = g / 255,
        b = b / 255,
        a = a / 255
    }, Color)
    
    return self
end

--- Returns the RGBA values of the color, eg. to be used in `love.graphics.setColor`
---@return number, number, number, number
function Color:get()
    return self.r, self.g, self.b, self.a
end

return Color